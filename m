Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CED339705;
	Tue, 11 Aug 2026 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469535; cv=none; b=ajGBabaA5/fxQhjVYN0L8Pwaw0hUJxtocPyH47fGrZHqQQfaIkX/0PfUO9O2anYVf3UrVJZBRw2AgzicwDG2+cpLTA1vtrIRnCuo8sQEX5re6zYlYq/zbK2cYtK3TH1bTmv4wxSGrr2vf1pdYX1LpcVK39SHOTH5K8NCLvqwKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469535; c=relaxed/simple;
	bh=QqO0j2c6r7g9BA7YoAvH+NwS0neorVa3jYF5X9EjN70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGpLcN1edYJFfkZYZ2/EY0F5lQUxH6u4bNqL42T/jCLtJl++uPiYu00QIpUbSUstoKuRzzxE8OLR0o6Jh/qLP80yQZoXCNTVZjIOAPDWeISunmsFKi61dEXbdKwT74dZJb+3eUYUf4xRQbDo/sPXququNtEwLni/JkXWUEH0rRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=XFV6YlmK; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="XFV6YlmK"
Received: from [10.0.0.152] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id E45995340EAE;
	Tue, 11 Aug 2026 19:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1786469526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yCXBQQM7CL+u5OEmmD6QLFGYIqNBJNpX9oWxOyohZ9Q=;
	b=XFV6YlmKDwJ63uG2G3xnjkUXt4dVpuBJEKZmH6Ai2+AphPpLFkpWErugOwAXdUsfv78cLq
	Ks+ouNvz+awDMujVfHIoWtzJPCdPFfwcf55s4kPpuUgItn3S6rG14JjL+MG74e6obCRK0p
	gQHa9q3OrGuYltbiYy8eFgWiExrOiPg=
Message-ID: <b707c629-97a7-4766-955b-64a2a7626004@ixit.cz>
Date: Tue, 11 Aug 2026 19:32:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFC: nxp-nci: fix deadlock between firmware download
 and IRQ handler
To: Ian Ray <ian.ray@gehealthcare.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= <clement.perrochaud@nxp.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Cc: stable@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260810082137.719-1-ian.ray@gehealthcare.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260810082137.719-1-ian.ray@gehealthcare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 10:21, Ian Ray wrote:
> The firmware download work function holds `info_lock' while calling the
> nxp_nci_fw_send(), which waits for a completion.
> 
> The completion is signalled by the IRQ thread handler, which also takes
> `info_lock', causing a deadlock.
> 
> Fix by dropping the mutex while waiting for the completion.
> 
> Fixes: dece45855a8b ("NFC: nxp-nci: Add support for NXP NCI chips")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> ---
> Changes since v1:
> - Fixes tag
> - Cc for stable
> ---
>   drivers/nfc/nxp-nci/firmware.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 

Hello Ian,

I checked the Sashiko review and it seems found an issue (feel free to ignore 
the 2nd pre-existing), could you check please (below)?

Thanks
David

--- Patch [1]: [PATCH v2] NFC: nxp-nci: fix deadlock between firmware download 
and IRQ handler ---
commit aeb1accbd1a732a455bf37b530649e8d9f406914
Author: Ian Ray <ian.ray@gehealthcare.com>
Subject: NFC: nxp-nci: fix deadlock between firmware download and IRQ handler

This commit addresses a deadlock during firmware download by dropping the
info_lock mutex while waiting for the IRQ handler to signal completion.

 > diff --git a/drivers/nfc/nxp-nci/firmware.c b/drivers/nfc/nxp-nci/firmware.c
 > index a9533977aff8e..38fcac26ce563 100644
 > --- a/drivers/nfc/nxp-nci/firmware.c
 > +++ b/drivers/nfc/nxp-nci/firmware.c
 > @@ -154,8 +154,13 @@ static int nxp_nci_fw_send(struct nxp_nci_info *info)
 >  		if (fw_info->fw)
 >  			schedule_work(&fw_info->work);
 >  	} else {
 > +		mutex_unlock(&info->info_lock);
 > +
 >  		completion_rc = wait_for_completion_interruptible_timeout(
 >  			&fw_info->cmd_completion, NXP_NCI_FW_ANSWER_TIMEOUT);
 > +
 > +		mutex_lock(&info->info_lock);
 > +

If wait_for_completion_interruptible_timeout() times out, could this open a
race condition leading to a use-after-free?

When the timeout expires, the IRQ handler might run before info_lock is
re-acquired here. Since the timeout path hasn't cleaned up fw_info->fw yet,
the IRQ handler would see fw_info->fw != NULL and erroneously call
schedule_work(&fw_info->work) for a late response:

drivers/nfc/nxp-nci/firmware.c:nxp_nci_fw_recv_frame() {
     ...
     if (fw_info->fw)
         schedule_work(&fw_info->work);
     ...
}

After re-acquiring the lock, this function returns -ETIMEDOUT, and the caller
nxp_nci_fw_work_complete() will free the firmware buffer.

Could the spuriously scheduled work then execute and dereference the freed
memory when it calls nxp_nci_fw_send_chunk():

     skb_put_data(skb, fw_info->data + fw_info->written, chunk_len);

 >  		if (completion_rc == 0)
 >  			return -ETIMEDOUT;
 >  	}

This is a pre-existing issue, but does nxp_nci_remove() have a use-after-free
if a firmware download is currently running?

nxp_nci_remove() calls nxp_nci_fw_work_complete() to free the firmware buffer
before cancelling the work queue:

drivers/nfc/nxp-nci/core.c:nxp_nci_remove() {
     ...
     if (info->mode == NXP_NCI_MODE_FW)
         nxp_nci_fw_work_complete(info, -ESHUTDOWN);
     cancel_work_sync(&info->fw_info.work);
     ...
}

Since nxp_nci_fw_work_complete() frees fw_info->fw without holding info_lock,
could the concurrent nxp_nci_fw_work() thread be actively copying data from
fw_info->data, resulting in a use-after-free or a double free if the worker
finishes and calls nxp_nci_fw_work_complete() as well?

This is a pre-existing issue, but is there a potential integer underflow and
out-of-bounds read earlier in nxp_nci_fw_send()?

Before dropping the lock, the firmware size is modified without a length
check:

drivers/nfc/nxp-nci/firmware.c:nxp_nci_fw_send() {
     ...
     if (fw_info->written == 0) {
         fw_info->frame_size = get_unaligned_be16(fw_info->data) &
                               NXP_NCI_FW_FRAME_LEN_MASK;
         fw_info->data += NXP_NCI_FW_HDR_LEN;
         fw_info->size -= NXP_NCI_FW_HDR_LEN;
     }
     ...
}

If the provided firmware file is smaller than NXP_NCI_FW_HDR_LEN (2 bytes),
fw_info->size (which is unsigned) will underflow to a very large value.

Would this cause the subsequent safety check to be bypassed:

     if (fw_info->frame_size > fw_info->size)
         return -EMSGSIZE;

and allow nxp_nci_fw_send_chunk() to read out-of-bounds heap memory?
