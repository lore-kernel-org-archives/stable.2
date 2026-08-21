Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB134753A
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283278; cv=none; b=bL4ZRNwwaWvF65yI9trzdB640wZIHByxJ/2MSvfBXWzkGPBi8H1OYRy82EfIhZynXXQGQ4eicGZzHL+xBY7YRrVXYC6S6yfZTnQ2tDxp3AjcJH9tfzeTK0lgZUBVLmL0bQihfXw3ZP3AFrtOUyEC1v030o7cwm2W2GvKcVY7W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283278; c=relaxed/simple;
	bh=o05anlxPo/5KSn/aC1nkPCiLXBtiyr08fsBT/c8SN30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaDJ6Z2GWq5cmL6nEIp1EchUvpWDyQnk2IgTIJeNPF6dl3fzWkq+KLIHJZFnjC0i0oFbwWLHS+a2wqP/awGoY5RKBnTmmiF0V0vEmu9sLvmNJZoXmw1YV/6w8Pd+TDhYfLR+2eR5415gixjqbAHaeWvpVKD0Vbj9XS9+DqF0TjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Azm5KQIN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHtuvbsk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azm5KQIN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHtuvbsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787283273;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sV6GZTlTkIDbe99yt+OpKn74mTgvPIvZYm3PDEYjGsc=;
	b=Azm5KQINMvp/JCcjuYRWnAmB16U2CHKXAVzy+W9JodbC9ay3dX6nKnoKdh8V2xTz2U7LQh
	M7x/4kFCot9X9PAIZpSaCmDB8+BJ0yNvoZet4ebpNSKG4QJdoTYiZ2iWU0g0UTfHhDQqE+
	e+wTr/xVV1++hWe4LIqvUWprLh64j4s=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-gf0W0mkBMCyl8s-Zp4Xvjg-1; Thu, 20 Aug 2026 23:34:31 -0400
X-MC-Unique: gf0W0mkBMCyl8s-Zp4Xvjg-1
X-Mimecast-MFC-AGG-ID: gf0W0mkBMCyl8s-Zp4Xvjg_1787283271
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4519fdc5145so854479fac.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 20:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787283271; x=1787888071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sV6GZTlTkIDbe99yt+OpKn74mTgvPIvZYm3PDEYjGsc=;
        b=hHtuvbskfi9I+1zitPwdksrylAaz4mmQoq+CznC5VHvLjoxGAgezNSqbNjSFXslyzN
         5VSoKWdRWcux1h37Zjnp7E61tfLjqMYuvZcOvVLNGnoI0dK3qfQFTDYO/gsjyWB6yU+w
         XrcDpT19q8IkERKg4gFVyWJEln97CVfhBxHmuEicmj5eXpax60w/XQebItyj6Gv1x2jJ
         LPJNR76cKTuIUzbGaYSgXE47QC6VdHkQHT58LdPo5LL7HVH3QhvIskJxLsMHyrXabABA
         YHO+rZ0+5C7kOu2pMO0omqL5aWyv6//3G1yzCnTcFDbkSMxbXvP5e/4dspxnx6/EZGX3
         +6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787283271; x=1787888071;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sV6GZTlTkIDbe99yt+OpKn74mTgvPIvZYm3PDEYjGsc=;
        b=ph+bA8rhUgbUPyebyqXLymG8ML2WdOnsPnesFuKQR9Hx5m9WF8vEIDXIFzKV/YwPq4
         iQqUxfTgIE2a5K8aLDrfuSzidkpMLPBapGwfzoKXhKudxCFFKb6frYTDbhPRhvtYLRNK
         h250beCEILs4WZz1+1d0L6MXIqqKezzLNWLqmWop1iqkjSIo5Yaza/DRUh17/Wi85Ekd
         Ud4p8vbdQU5mbk+CWUSiLWMiZBR5jqGJ6Bx10g6IIjk6NfNEIfHF5/QgBcR0tIHYTLqK
         dn01yqs/IjQ2pHwEtXAEQOWDYRM4gxLbjEUvfS1N8k0iSV3X/Eq64j733I2+S3DzvXH3
         VIag==
X-Forwarded-Encrypted: i=1; AHgh+RoMLJuuqZmjC4eQAKUR3jYYk3ca5MqdV/xrBZlGTog8Zk8ZG/s3WKSUAUihi0yQN9ZWeI6V3nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKM0xw4HMmWiP+PQX8hK61tD0eefjMGsY1mwhLFlhZqbw/Hzk
	Md6Dm/hsL5HyzArUjCiHIUgDaGAsUVnQyw142d1aDvy0X6gBml/MpkA9/QRDYw9vrjXnmx015qc
	ryuakuG7wlklULwMXLuvWZ99tcdS5nplo/IMIj1qO7D2euqydut8m1Lg4iw==
X-Gm-Gg: AR+sD12tT7mdpFEAMjQ0pc21HS2LfXYWIgHXOsk5lPcbgXbyUMLSONWp6cJD/Inf2qw
	f6xb/l3DXI0VxixQib3M2bTxOQhNxeWeuQvyhy0CyhSlrnOR1Y4oB4HFl++xRqaWz1CtfCYrVOA
	vNBmRnHhZ68WGChTupgA/k43UOFssGr6wCiKrZRxDFqxxxhTuZYnNgvQuurvA62pxh0j8+lhVIx
	mhBNiAH5c5ZxggCnvW2E0dsWsldJ+DtOMskfQljRJAzHc77ufPGy815MmxlCMgQD9cVgHACIFlc
	iG38ZDUxX9OBwl/kJTQ14YVV7+y9EnkQ7OiImjDYLO4lMJLbHjKkBaWYxpeIPFNjI+b/hTMYZ8t
	8Ni+z22qaddn7EiT4CoX2u9dSe33smmtIIU5LB0Lp
X-Received: by 2002:a05:6820:a285:20b0:6b1:2843:1309 with SMTP id 006d021491bc7-6b1593f3e55mr2716772eaf.26.1787283270709;
        Thu, 20 Aug 2026 20:34:30 -0700 (PDT)
X-Received: by 2002:a05:6820:a285:20b0:6b1:2843:1309 with SMTP id 006d021491bc7-6b1593f3e55mr2716754eaf.26.1787283270302;
        Thu, 20 Aug 2026 20:34:30 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6d9b75sm3505181fac.8.2026.08.20.20.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 20:34:14 -0700 (PDT)
Message-ID: <190c5d5c-251f-45ef-80d9-00e4ad896b2e@redhat.com>
Date: Thu, 20 Aug 2026 22:34:12 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: [PATCH] cifs: fix i_size inconsistency in
 smb2_duplicate_extents() on FSCTL failure
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, stable@vger.kernel.org
References: <20260820211443.1472310-1-sorenson@redhat.com>
 <CAKYAXd8xbGTc8ADKqR1VMw1SETLDvFwrbnahp+4pWFTamZLB=w@mail.gmail.com>
From: Frank Sorenson <sorenson@redhat.com>
Content-Language: en-US
In-Reply-To: <CAKYAXd8xbGTc8ADKqR1VMw1SETLDvFwrbnahp+4pWFTamZLB=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/20/26 8:02 PM, Namjae Jeon wrote:
> On Fri, Aug 21, 2026 at 6:14 AM Frank Sorenson <sorenson@redhat.com> wrote:
>> smb2_duplicate_extents() pre-extends the target file before sending
>> FSCTL_DUPLICATE_EXTENTS_TO_FILE.  If the FSCTL fails (e.g. ENOSPC,
>> byte-range lock conflict, unsupported file combination), the server
>> and client i_size are left reflecting the larger size while the data
>> in the extended range was never cloned.
>>
>> Save the original i_size before pre-extension and restore it on FSCTL
>> failure.  If rollback fails, force revalidation instead.
>>
>> Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate extents (reflink)")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
>> ---
>>   fs/smb/client/smb2ops.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
>> index 7d6738ffcb80..38bd344a9740 100644
>> --- a/fs/smb/client/smb2ops.c
>> +++ b/fs/smb/client/smb2ops.c
>> @@ -2200,6 +2200,7 @@ smb2_duplicate_extents(const unsigned int xid,
>>          struct duplicate_extents_to_file dup_ext_buf;
>>          struct timespec64 ts;
>>          struct cifs_tcon *tcon = tlink_tcon(trgtfile->tlink);
>> +       loff_t orig_size;
>>          u64 asize;
>>
>>          /* server fileays advertise duplicate extent support with this flag */
>> @@ -2218,7 +2219,8 @@ smb2_duplicate_extents(const unsigned int xid,
>>                                 trgtfile->fid.volatile_fid, tcon->tid,
>>                                 tcon->ses->Suid, src_off, dest_off, len);
>>          inode = d_inode(trgtfile->dentry);
>> -       if (inode->i_size < dest_off + len) {
>> +       orig_size = i_size_read(inode);
>> +       if (orig_size < dest_off + len) {
>>                  rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
>>                  if (rc)
>>                          goto duplicate_extents_out;
>> @@ -2235,6 +2237,23 @@ smb2_duplicate_extents(const unsigned int xid,
>>          if (ret_data_len > 0)
>>                  cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
>>
>> +       if (rc && i_size_read(inode) > orig_size) {
>> +               int rrc;
>> +
>> +               /*
>> +                * FSCTL failed after we pre-extended the file.  Attempt to
>> +                * restore the original size so the caller sees a consistent
>> +                * file rather than a larger file with uncloned content.
>> +                */
>> +               rrc = smb2_set_file_size(xid, tcon, trgtfile, orig_size, false);
> orig_size is only the locally cached size, and
> lock_two_nondirectories() does not prevent another SMB client from
> modifying the file. If the FSCTL fails, this rollback may truncate the
> server-side file to a stale, smaller size and delete data written by
> that client.

Hmm, yes... it's a fundamental problem; we only have the locally cached 
size.

So if the FSCTL fails, we need to force revalidation and invalidate the 
cache.

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

