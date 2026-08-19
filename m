Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5830568F;
	Wed, 19 Aug 2026 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154689; cv=none; b=qFLxBgoMDw25SYIbKVGmIF7LnzAKWuxwxEVeocQBqsACqXIFlQHqSzGOj9DBn/qfAHjTwBjAxsJdYmCHgm+SJxGhGM5Vr6pd+FETuLQ/j1ypTQ93gHZqQiYJ1vmVIlfKc3jYv1RtaouR6uxwI3bzpHrKjJvPELMXpa4Tnz7XrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154689; c=relaxed/simple;
	bh=d6q3s7JsgURID163rxq4Cz4uT5yV6jdD3JqLfR+d+2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUACFnuX9CzWCM9Qkuv7D/hLsonrOw2lR/vx9ZvYare9NgOv0hxKd7cRJIDeHaT9pPUQD3/e1lqDJSjbB/VatYjS751ATPdZF+sB9GlMe5HVPqJj9YFV+x31x4lEkbuePzVS/3LyrYMsd/Ij/AwSoMCICKYbFQrDKVQS8+g7wgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx8kqnQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx8kqnQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400C11F000E9;
	Wed, 19 Aug 2026 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787154688;
	bh=TMLxF/IB0sC5lGiI6MnZO8aVMsnVp3pHfBnlMppNdQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cx8kqnQaQtVafLngJRVs2qDCdx2l5LVgMj8+8qd54/vFyGVPbZ+TkrIxle8Qxn7uV
	 RdcyBCUnY1q996smaHB9r4k3p6wSqfylVsYQiVVY5aLIg8pheSTIAY7vTnVaFdVxQc
	 iUMbqR7kuba6QDAzUPHlFjAxiQdqhqxlu8mkutVpQNU6JGz3GAOkDhWJ705FlAvxo9
	 j/oPZxKvlLce7ESBvYwBHq/Oj0kCUcUEKB0Gcs9hMCiof8X6zuP09J15CV1hfNAeEc
	 Lbaia/O9yl3Tv4jZ19MH/Cwaoml5kJXU+3Gx7pmxkKOKsoejtayV9aKgFHxxHG7Png
	 ORBKVQhIMwMFQ==
Date: Wed, 19 Aug 2026 16:51:22 +0100
From: Simon Horman <horms@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH net] ice: fix metadata_dst refcount handling on
 representor teardown
Message-ID: <20260819155122.GU265046@horms.kernel.org>
References: <20260816135510.1015041-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816135510.1015041-1-tristmd@gmail.com>

On Sun, Aug 16, 2026 at 01:55:10PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> ice_eswitch_release_repr() uses metadata_dst_free() to release the
> representor's metadata_dst.  metadata_dst_free() directly frees the
> underlying memory without checking the dst_entry refcount.
> 
> When ice_eswitch_port_start_xmit() processes a packet, it takes a
> reference via dst_hold() and attaches the metadata_dst to the skb.
> If the representor is torn down while packets are still queued on
> the lower device (e.g. in a qdisc), the metadata_dst is freed while
> references are still held.
> 
> Use dst_release() instead, which correctly decrements the refcount
> and only frees the object when all references are dropped.  The dst
> subsystem already handles metadata_dst cleanup in dst_destroy() when
> DST_METADATA is set.
> 
> Other drivers sharing this pattern (nfp, airoha, bnxt) already use
> dst_release() for their metadata_dst lifecycle.
> 
> Fixes: f5396b8a663f7 ("ice: switchdev slow path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Reviewed-by: Simon Horman <horms@kernel.org>

