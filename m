Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4E224B05;
	Tue,  1 Sep 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282052; cv=none; b=sunUlCzI020z3v1HLTh8QHafD6xbg4SbhAOd9dgFvUp1dNT0n+M0CK2RiDFwxlAV1jrYlfkw9pKmc1Fv9SURs8OaCdLk+NeyZ4W6NE0H73UurU3Zjz+xbNkvKl8YBOgmieasULovtGu2lMqdBFHV06ELxW6tYm6x/r3q1A8g4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282052; c=relaxed/simple;
	bh=NWSiI1enUnUaSBmQdqUlReXZnZWVoLZRATVco5bM2Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coWyv4lL3P0JB9IH7GkooekJtzhkMKWOVS5piY5Xkf7cRbfPBT20woniVHfvdPJHV2A1mqGDKrk7jg8u/EmMvtoinYedZwj34U85lJhVXJqVqGxeijIKB/2neDespT5p3qx7qJvIw2PTmjK2vlOzjQn8ShZYc122ETABKuuh3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCODEhCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCODEhCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DB21F000E9;
	Tue,  1 Sep 2026 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788282051;
	bh=C+KVJ0lWosibzsMOGpfGHo+pN4oPGLtksyZr/vqNRtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YCODEhCRxAakqfpnA9lB2tv0SSHccaOI3Wrg4qGT2hCYiteoE3lBG7I1fjWsTk+4V
	 257HRL7Dohpia8DD0jeVbKUdG8b6PemkfPdCnLNYc3QohrhXh2yFvjSoAB3SQR6PeR
	 wX/HIojGXY0HDfej5RLVo44QnVqvkZBb+YdoDG7s=
Date: Tue, 1 Sep 2026 19:00:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync
 entries on cancel
Message-ID: <2026090140-fiber-risk-346e@gregkh>
References: <20260901154427.3991920-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901154427.3991920-1-lee@kernel.org>

On Tue, Sep 01, 2026 at 03:44:26PM +0000, Lee Jones wrote:
> In send_cancel(), pending mesh_tx objects are removed from the
> hdev->mesh_pending list and freed via mesh_send_complete(). However, if
> a mesh transmission was already queued onto hdev->cmd_sync_work_list
> via mesh_next(), the queued entry retains a raw pointer to mesh_tx.
> 
> When hci_cmd_sync_work later processes the entry, it attempts to
> execute mesh_send_sync and its destroy callback mesh_send_start_complete
> using the already freed mesh_tx pointer, leading to a use-after-free.
> 
> Fix this by invoking hci_cmd_sync_dequeue() for mesh_send_sync on the
> target mesh_tx before completing it. If the entry is found and dequeued,
> its destroy callback will complete and free the object; otherwise,
> mesh_send_complete() is called directly.
> 
> Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> 
> v1 => v2: Email address switch - no functional change
> 
>  net/bluetooth/mgmt.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
