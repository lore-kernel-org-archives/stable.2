Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F449CF20;
	Thu, 24 Sep 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264233; cv=none; b=NEp4rJTJ8lm42Hu7izaWg3HVUktCiznMazrR0J55GQ8lJfvbQfpNtySRiEcXwjLQxf1h8qVHdSX/yGcDhFFY9ITv/LvoizM/yAp7ZVTR/DGWyC6SWgo5garKAy2NYZ2xqWLZpCVIpXmwQeCJCT34dKCz0uQwYDXq/BSKpcWCTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264233; c=relaxed/simple;
	bh=LtlID1Tut84vhZMMIt6dhqBV++ovLnqLdWrDbAfps5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U33CG0uWKxTbPR6Tgn4GF40MD7HXH4IyZ+F46yVdH5WRW/XCJayAOKnCQjh2ZsHopfl/gzi1lv66WTn40eX9HFmpLAAKgpfLKkcHs4Y/GEBJBe8eDGkVoqZY1fsXAh5xUxZCRGVI61Vy0yMuhQ9rOSb1S+lONeaG5KkWQQbnM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Y5Fhi7Rz; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Y5Fhi7Rz"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B00861D78;
	Thu, 24 Sep 2026 15:38:03 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=Y5Fhi7Rz;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6963B1D70;
	Thu, 24 Sep 2026 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1790264228;
	bh=aNerNzZMBL5stsqR6RVjnN5baso0dUCYrXQWA/vpOz8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Y5Fhi7Rz7gPWXAUGjpEniAwnYXR0X1dNav8qVg8haRcfBkFXxouofzaV+isXpl47U
	 quVA4b7OhboEx5t6kWRJjPAwgOCcfM+MKwRHeUNwMlT/XT0F8IN5gKin+zf9BFYbzd
	 RhTn9OJbsnCqRnUPnHln36PAUwRJ3P3SdaBRbKBI=
Received: from [192.168.95.128] (172.30.20.214) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 24 Sep 2026 18:37:07 +0300
Message-ID: <63dedf61-1e76-421f-9b7f-c4e463f21aa8@paragon-software.com>
Date: Thu, 24 Sep 2026 17:37:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix OOB write if err == buflen in ntfs_readlink_hlp()
To: =?UTF-8?Q?Alexandro_Cal=C3=B2?= <alexandro.calo@nozominetworks.com>
CC: "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <029C54CF-FC6C-4BFA-854C-847F8E656626@nozominetworks.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <029C54CF-FC6C-4BFA-854C-847F8E656626@nozominetworks.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/8/26 13:30, Alexandro Calò wrote:

> [You don't often get email from alexandro.calo@nozominetworks.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
>  From 64361f8e12081dc8828480588bc48c2c931ffc91 Mon Sep 17 00:00:00 2001
> From: Alexandro Calo <alexandro.calo@nozominetworks.com>
> Date: Wed, 8 Jul 2026 12:04:37 +0200
> Subject: [PATCH] Fix OOB write if err == buflen in ntfs_readlink_hlp()
>
> ntfs_utf16_to_nls() may return buflen. The caller later uses the returned
> length as the index for writing the trailing NUL byte,
> so err == buflen writes one byte past the end of buffer.
>
> Fix this by limiting err to the last valid buffer index before writing
> NUL.
>
> ntfs_utf16_to_nls() returning a negative value is already handled by
> if (err < 0) goto out;
> As long as buflen is guaranteed to be nonzero the patch is fine.
> As a defensive fix if(buflen==0) could be added.
>
> This heap out-of-bounds write requires a crafted filesystem image,
> which is not in the kernel threat model, but fixing memory errors would
> be nice to keep things secure.
>
> Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
> ---
>   fs/ntfs3/inode.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 0c9bd669117d..d4803e1625fe 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -2029,6 +2029,9 @@ static noinline int ntfs_readlink_hlp(const struct dentry *link_de,
>          if (err < 0)
>                  goto out;
>
> +       if (err >= buflen)
> +               err = buflen - 1;
> +
>          /* Translate Windows '\' into Linux '/'. */
>          for (i = 0; i < err; i++) {
>                  if (buffer[i] == '\\')
>
> base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
> --
> 2.47.3

Hello,

Sorry for the delay.
The patch is applied, thanks.

Regards,
Konstantin

