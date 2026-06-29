Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8711B86C7;
	Mon, 29 Jun 2026 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782707826; cv=none; b=p98nSP5vlDnNJqA2qdyLzPiLRjmkX5Cpo4WtXteLiXdpKjsoreXH/lo3qrdsO8KqB2zQ7Xw1TQG2/Fvpo1RT7SjTY6U0yz5hXCSxiNEon0TAwD/ulrbBNKi6McHkdinA8N5nlM7VF5ig4UCcZLcZ8PzrC53YSPKfMpaT1Guat38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782707826; c=relaxed/simple;
	bh=83+x3RkqgesZ3FFrecxekAZQqaAoQ+G7ED/qjYGvuT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2ygdJJddNjGp24m6Rq6sie2RxWdxduXYnxpVHcoyuJNXkk/xGw+LDRFHd/eotqw2yaWRs3A+BpTmWvzGNMLCBwPAKu/HM2Ci8uMSr6Cwr6UkJTmdNeHmJwvA0RhK2mHx/xNEE/CibMPKWXHx4A5pU18Dg/mKd3+a04Aeq4Bx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K1xE2PRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K1xE2PRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CCA1F000E9;
	Mon, 29 Jun 2026 04:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782707825;
	bh=UA/8TEqnLRBtg+CS42jkaVku5zkA76i8pZuF/RPL1ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K1xE2PRee0tRW5Fj0/Pog1F+wyeWXqy7MTwYeWptzrT+TbYhTfIHi//3TmCWCX8HJ
	 SJqk7+HQ+bznYv7rNlG7xV//+CS0uFiUL5jfy2gyfanZk5WoCPtaVzeW0/zQy9Bkk9
	 otphbhj2ungjvDCfE6vmholxEKjaj+b49QjtVi7o=
Date: Mon, 29 Jun 2026 06:35:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kees@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	tomi.valkeinen@ideasonboard.com, mcanal@igalia.com,
	suraj.kandpal@intel.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/display: fix MST branch device refcount leak on
 DPCD write failure
Message-ID: <2026062906-bonding-pointless-f53d@gregkh>
References: <20260628133344.46188-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628133344.46188-1-vulab@iscas.ac.cn>

On Sun, Jun 28, 2026 at 09:33:44PM +0800, WenTao Liang wrote:
> drm_dp_add_mst_branch_device initializes mstb with refcount 1, and
> drm_dp_mst_topology_get_mstb increments it to 2. When
> drm_dp_dpcd_write_byte fails, out_unlock performs only one
> drm_dp_mst_topology_put_mstb, leaving the other reference stored in
> mgr->mst_primary. Since MST was not successfully enabled, no disable path
> will clean it up.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>

I did?  Where did I do that?

> Fixes: 7a3cbf590e63 ("drm/mst: Some style improvements in drm_dp_mst_topology_mgr_set_mst()")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Again, you need to document the tools you used to find/fix this with
assisted-by, right?  Please read our documentation for when you use
LLMs.

thanks,

greg k-h
