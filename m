Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72E2D5436
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695868; cv=none; b=Y2ZxD2YMbxEtuZy1Q8XE3fJUd+wCfWMEXnTG6UGYNo0C90orlB0Aty9PhGTxkgtbNXSz+xVxwOHulwhGx8cLKt0i8nBS9NcfFg153VDai7YmSegOxao8wx8ZRFqtsxwVMVSB5bVUyQcBBTAq8AWr24902fMrK8RWhgQXfFjxx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695868; c=relaxed/simple;
	bh=AhuZwVTTC/1nU6YkD/HCUC2pbhEU63P/DHqLsiNyDk0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ruc8jrHIDAUcfhSSz0oIbp/RaGNVv4qt8AS3HIwzoYSrTpqlJD/KSyA1U5wTgfjiGYoURbeQyrsSiKenWHCeViLUK47QKAe6X4fwdQtnhRp53+M2ZzhF7Oq5YylldBgnh5eT5NqTqda8M3lhGSKtGCgK34P26Y+5OXRbDIbqhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyuAnGqC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmLEfcEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyuAnGqC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmLEfcEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789695866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gmK8P3XeCEw2Kl7yv61jHybl1lElrtzJ9/W+3yl0xM=;
	b=SyuAnGqC5FxKHX5ynKkZ0sMgvada9IOvu2kuUExIx/yxoP7Lc6QR3QkVPZzVn/Z9vdz7Pi
	GS9jattHRJ1r4TJEfVp8olRu2QpdqPH7IMlU98RtzUyon1qagwqcu7u9ESUfqX7LcnjtQk
	fDutCKYnGye9LvzZ3EwK0Ss1v9Gd1oA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-PsUvJdobPjW-LjkHIpIzjQ-1; Thu, 17 Sep 2026 21:44:20 -0400
X-MC-Unique: PsUvJdobPjW-LjkHIpIzjQ-1
X-Mimecast-MFC-AGG-ID: PsUvJdobPjW-LjkHIpIzjQ_1789695857
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530f968ccb3so2996441cf.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789695857; x=1790300657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/gmK8P3XeCEw2Kl7yv61jHybl1lElrtzJ9/W+3yl0xM=;
        b=TmLEfcEjrV5d1Nh0DFP2CNJrspFy/qj4cQfo3bA5Uk2ugileilIaAHWn4qn0JK5xpM
         OSW3iZkFfXv5riPKD8KA/PZR4iznRbjETd+mgwegeUvReluP6RH8ytPzejKrE1fpgc42
         p6BoxRwuwkMxY/6JG3J5NvHJZr9KF5Shd1fERDab0wjUVol0WEH2KnHHSWyVVNkg8XWI
         S5k6ey+qiZbviuta5+DNNB3qtrARCUDnoxr2Tsnsi3MvQBvWRpyu3HIos8gtkPZB+xpI
         ryGv6zzRMAk7E/HOmTuYcMeP1NOFOE3QSWqm4RcBNZ0diL/xxsJ5Gfi0jiMp64b97Cwn
         y4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789695857; x=1790300657;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/gmK8P3XeCEw2Kl7yv61jHybl1lElrtzJ9/W+3yl0xM=;
        b=XqCJrhp8IjRbqMgDNFelSd34X8CGEqjOymRVcH3GTY69NlegwyR+18nAkW3egmJFyZ
         b+dZtLyyAo1mPYYm3r5QPP2ZFoXcVYkDd/mpCyioz0z82LA5d7att1nhLiqtdVXI3aqt
         blPH+AhDf5d3X22ahfB3+y191d2UjrFBQwdXGzRKE2b16XOYYZJ9FhZHmDOEXpTWZTCi
         Fe75ZkTCm89ZsgvkBNtzdkbhrCsBez57FQAZg+oOqugrKf3Xs/5WdEmeRuqztEB+mCkI
         ZtuvDKIF+cNDkb3hc44m110gOC9Y+eYLzTkOac0CbS9rLdDcJMVOVdeRjGwB3gkKgpjr
         EGkg==
X-Forwarded-Encrypted: i=1; AKwUvBwQxpYfCisvJFIx/hNbzNw8bnjZ8rTb0BlBbVUJEce33upVBCRzgzv8IIeK7KdRDoahkfZqkgM=@vger.kernel.org
X-Gm-Message-State: AFuF++mLQBYYjaczH/iEk7bOACnA3xNXKLl/8tbk7mA/nwIxz+JVLJfR
	cuz+vlfnwxR07WiFqIK8nmxMXjJvdXFCldYVXtxnitlB6OQv7IecUWIVfPnuYRi6l0C5nw3OCp3
	ojKFj95ipLzRv48P6MRR/OkqNYtniuryW60xB8iUkD/swPWGfp8uYjhdKpaMGlzOJzQ==
X-Gm-Gg: AYBFou3JlXtQqksRThT7Yloa5lAbyf77Jxc8Q7Zs85NjNcnChU9Dzymalt9GTgFTOpL
	fpvY+daBUQm7w7i3JJmASZgkphcZcjsGPTNu1bAMagIKVp/IMM7C6AwmQo2icPRM1HruOqn7/BX
	AUZtUZrx7Mki4jSkk8VFHlf4k3M7GnL1phe/951Fjdakk2gNCiaEREAfiP9ufI9vADSuTETUkIe
	Dm+QjJnzfg9gv2UIPY8Y1RM1qGyHkGULaEb2/9YxK8kO76HmAt4E8BuZlsmsVy6x9xyt9IK2J20
	gBn4i2D/pcFg5agx/H5Blo6KEgyHVFNWTHhiGNcGqmPqWnqw+gOfuU647gNx9OAOKRmn4C+TbLz
	ajZVPFS395+VEtZAJnZxj09YfD/jN/qpn5BMzYLFZ
X-Received: by 2002:a05:622a:4292:b0:530:dab5:d43a with SMTP id d75a77b69052e-5329e2aafa3mr19749081cf.24.1789695857496;
        Thu, 17 Sep 2026 18:44:17 -0700 (PDT)
X-Received: by 2002:a05:622a:4292:b0:530:dab5:d43a with SMTP id d75a77b69052e-5329e2aafa3mr19748911cf.24.1789695857054;
        Thu, 17 Sep 2026 18:44:17 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532a19a452asm1997361cf.14.2026.09.17.18.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 18:44:15 -0700 (PDT)
Message-ID: <798adeb8-ef0f-47d6-9934-a19a23cafa4f@redhat.com>
Date: Thu, 17 Sep 2026 20:44:13 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smb: client: fix potential use-after-free with
 TCP_Server_Info->hostname
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org, pc@manguebit.org
Cc: linkinjeon@kernel.org, stable@vger.kernel.org
References: <20260918003327.2539470-1-sorenson@redhat.com>
Content-Language: en-US
In-Reply-To: <20260918003327.2539470-1-sorenson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please disregard this patch.  Two of the cifs_server_dbg() are called
with 'type=ONCE', for which cifs_dbg_func() doesn't ever print.

I will re-evaluate the rest of the patch and may resubmit the
other hunks later.

Frank


On 9/17/26 7:33 PM, Frank Sorenson wrote:
> The TCP_Server_Info->hostname pointer may be updated during a reconnect
> event. Accessing ses->server->hostname outside of the srv_lock is
> unsafe and can lead to a use-after-free if another thread reallocates
> the hostname string.
>
> Fix this by replacing instances of cifs_dbg() that print the hostname
> with cifs_server_dbg() across multiple files (smb2ops.c, sess.c, and
> smb2pdu.c).  cifs_server_dbg() correctly acquires the srv_lock before
> printing and standardizes the output by prepending the server hostname
> to the message.
>
> Fixes: 4659f01e3cd9 ("smb3: do not log confusing message when server returns no network interfaces")
> Fixes: a6d8fb54a515 ("cifs: distribute channels across interfaces based on speed")
> Fixes: f591062bdbf4 ("cifs: handle servers that still advertise multichannel after disabling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
> ---
>   fs/smb/client/sess.c    | 5 ++---
>   fs/smb/client/smb2ops.c | 7 +++----
>   fs/smb/client/smb2pdu.c | 5 ++---
>   3 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
> index e095f41b5882..5c2c9cabf7ef 100644
> --- a/fs/smb/client/sess.c
> +++ b/fs/smb/client/sess.c
> @@ -192,8 +192,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
>   		spin_lock(&ses->iface_lock);
>   		if (!ses->iface_count) {
>   			spin_unlock(&ses->iface_lock);
> -			cifs_dbg(ONCE, "server %s does not advertise interfaces\n",
> -				      ses->server->hostname);
> +			cifs_server_dbg(ONCE, "server does not advertise interfaces\n");
>   			break;
>   		}
>   
> @@ -395,7 +394,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
>   	spin_lock(&ses->iface_lock);
>   	if (!ses->iface_count) {
>   		spin_unlock(&ses->iface_lock);
> -		cifs_dbg(ONCE, "server %s does not advertise interfaces\n", ses->server->hostname);
> +		cifs_server_dbg(ONCE, "server does not advertise interfaces\n");
>   		return;
>   	}
>   
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 3464470d3297..08ea340f01b6 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -632,6 +632,7 @@ static int
>   parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
>   			size_t buf_len, struct cifs_ses *ses, bool in_mount)
>   {
> +	struct TCP_Server_Info *server = ses->server;
>   	struct network_interface_info_ioctl_rsp *p;
>   	struct sockaddr_in *addr4;
>   	struct sockaddr_in6 *addr6;
> @@ -666,10 +667,8 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
>   	if (bytes_left == 0) {
>   		/* avoid spamming logs every 10 minutes, so log only in mount */
>   		if ((ses->chan_max > 1) && in_mount)
> -			cifs_dbg(VFS,
> -				 "multichannel not available\n"
> -				 "Empty network interface list returned by server %s\n",
> -				 ses->server->hostname);
> +			cifs_server_dbg(VFS,
> +					"multichannel not available - Empty network interface list returned by server\n");
>   		rc = -EOPNOTSUPP;
>   		goto out;
>   	}
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index dea05aeb53a1..bb30cfa156aa 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -173,9 +173,8 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
>   	unsigned int chan_index;
>   
>   	if (SERVER_IS_CHAN(server)) {
> -		cifs_dbg(VFS,
> -			"server %s does not support multichannel anymore. Skip secondary channel\n",
> -			 ses->server->hostname);
> +		cifs_server_dbg(VFS,
> +				"server does not support multichannel anymore. Skip secondary channel\n");
>   
>   		spin_lock(&ses->chan_lock);
>   		chan_index = cifs_ses_get_chan_index(ses, server);

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

