Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184843;
	b=q4vlEUcFjD44eTQjFVT9HdVFhi3nmWHcM49YaAeBk+UlDjDsrlUDdGBpioZPVidH5DVi
	 JN3cNEHoCe14qPaRsIydXY+xxPpyjNCnry5SFXH9pum21AGHtMFRuZT7fTXY6yZt0itSY
	 6ncqHLc5gXOa6GJrSAa2Kqb3YfOE3xCMJpaKcZp7Ji69EzL9OMjAmFWdKaD5CritYuSV1
	 PEJroNVds0lkFt3m3GdYNRDku9vULjM7G3TmMx5BJR8P+hi+hyEPZis3NDJ/161Hr33KE
	 p+I3RUA/xxQ3K8KRf8gh0v9DhYKvimcQrHIcUPtbwUFh6a3KVsRFv7Bp8uMWzqCCFLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184843;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=X5uMGtPn4ARocnI6PlxLm4xxrDwcmpIfjMn71WllvfQ=;
	b=euu42yb/wwSIUve/pBJVsE0VLO/TFTnqT5GLDUcfyCXYRHGwG/uVCz04+a541InVrv7U
	 /BIAUGt1L7vjO9r0sQcBAi8xrJI4A0SgT00PggIw07OazsPmqqEusEc5PDYoBywZiStxK
	 s0qZnWT/LBNFC3F1pLZkDmyvi9AycJcOXuB34fmF3xZMFozRU4SYIOwAd9o3U7h6j10kW
	 kk+rBylqzYMpnEOLeLAw4RgRaJq/dq1IeEfh0HGsfFgMTergXDu82qHige2I1cy+J4Cl9
	 AJPXeawGolps1u/VMoAs4POjPFjKhLx9uTM+lfwLgHRwXRmECP93xFoprXcv1urEEiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VjcvCpSA;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011ED606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 011ED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VjcvCpSA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=X5uMGtPn4ARocnI6PlxLm4xxrDwcmpIfjMn71WllvfQ=;
	b=VjcvCpSAqVfy/z/9RtpYE/JTtDpwg0Lyj0LVqVafgd3XZFzOVtXgOtiUq9RlF+
	rKqcCH6S/MggoxeZ5ON39evY3FnFHiSPiSlTa83faQolLTBeumEadov2w5MGeiuQ
	PEhGA5F11cfXC8qzqveTfy1L0vQ19vs0GE7C5gHaQQWpM=
Received: from [IPV6:2409:8900:1e87:c681:e0d9:72d0:20c3:a0ec] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3n0ORWABrJM58JA--.47517S2;
	Fri, 20 Nov 2026 22:26:27 +0800 (CST)
Message-ID: <ee94181c-784f-4f9b-8697-cca5abec6b07@163.com>
Date: Fri, 20 Nov 2026 22:26:25 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][NTFS] Linux 7.3.4 mounts 64K-cluster NTFS read-only
 after $MFTMirr record 24 mismatch
To: "d3nchk@outlook.com" <d3nchk@outlook.com>,
 "ntfs@lists.linux.dev" <ntfs@lists.linux.dev>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "hyc.lee@gmail.com" <hyc.lee@gmail.com>,
 "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <VE1P190MB0877D026E2C3905F0324B46F85782@VE1P190MB0877.EURP190.PROD.OUTLOOK.COM>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <VE1P190MB0877D026E2C3905F0324B46F85782@VE1P190MB0877.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n0ORWABrJM58JA--.47517S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1rCF4UWw4UGw4xZrWfuFg_yoWrGrW3pr
	Z0ywnxtF4kJ34Duwn7tFWxJF90y34SyF4Yqa4kGFy5Krn8JFW0qrySqr4a9a9xArySgw4q
	qFyqg343KFZrCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRpwZ3UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6RMV32sAWJPtwAAA39



在 2026/11/20 20:49, d3nchk@outlook.com 写道:
> Hello,
> 
> Resending in plain text because the previous HTML-formatted message was rejected by the regressions mailing list. Apologies if this creates duplicates for other recipients.
> 
> I am reporting a regression in the in-kernel fs/ntfs driver (NOT ntfs3).
> 
> Environment:
> - Distribution: Debian 13, backports kernel
> - Working kernel: 7.2.12
> - Broken kernel: 7.3.4+deb13-amd64
> - Device: /dev/nvme0n1p1
> - Filesystem: NTFS 3.1
> - Cluster size: 65536 bytes
> - Mount options: defaults (including errors=continue)
> - Driver: fs/ntfs/ntfs.ko.xz
> 
> Kernel log:
> 
> ntfs: (device nvme0n1p1): check_mft_mirror(): $MFT and $MFTMirr record 24 do not match. Run chkdsk.
> ntfs: volume version 3.1, dev nvme0n1p1, cluster size 65536
> ntfs: (device nvme0n1p1): load_system_files(): Errors were recorded during mount. Mounting read-only. Run chkdsk.
> 
> This volume worked read-write with kernel 7.2.12. After upgrading to 7.3.4, it is forcibly mounted read-only, making normal file operations impossible.
> 
> Windows chkdsk has been run repeatedly, both through the GUI and command line, including dismounted-volume checks. The issue persists after rebooting into Linux.
> 
> I suspect commit 749357bd48c16c4cdc09093450deca609492f012 introduced the new read-only behavior for this case.
> 
> There is also a potentially relevant NTFS compatibility issue: modern Windows may not keep all $MFTMirr records synchronized on volumes with large clusters. Here the mismatch is reported at record 24, beyond the first 16 records.
> 
> Please investigate:
> 
> 1. Whether the comparison of MFT mirror record 24 is valid for modern Windows-created NTFS volumes with 64K clusters.
> 2. Whether this is a false-positive filesystem corruption report.
> 3. Whether errors=continue can be honored for noncritical MFT mirror mismatches, while retaining mandatory read-only protection for Windows hibernation and genuinely unsafe filesystem states.
> 4. Whether a fix can be backported to the Linux 7.3 stable series.
> 
> This regression prevents normal read-write access to this volume.
> 
> Thank you.

Hi,
    Thanks for the report and the detailed logs.

    I checked 749357bd48c1. It didn't introduce the mirror comparison,
but it did make errors recorded during mount force a read-only mount, 
even with errors=continue. That explains the change in behaviour you're 
seeing.
    There is a known compatibility issue with the comparison itself.
On volumes with large clusters, Windows 10 can leave later records
in $MFTMirr out of date.

    ntfs-3g already handles this by comparing only the first 16 records, 
or fewer if the mirror is smaller. See commit 85e208176ffd ("Stopped 
checking matches of MFTMirr against MFT at record 16").
   fs/ntfs still compares the whole mirror. With 64 KiB clusters and
1 KiB MFT records, that means records 0 through 63. A difference
at record 24 could therefore just be a stale mirror copy, rather
than filesystem corruption. Your report looks consistent with
this case.

    I'll follow the ntfs-3g approach and limit the record checks and
comparison to the first 16 records within the mirror. We'll still
read the full mirror and check its location, and leave the mirror
writeback range unchanged.

    This should allow read-write mounting in this case, provided
there are no other errors. We shouldn't need to relax the general
errors= handling or change the read-only protection for hibernated
volumes and other unsafe states.

    I'll include a Fixes tag and Cc stable so the patch can be
considered for the 7.3 stable series after upstream acceptance.

    I'll send the patch shortly and CC you. You can then give it a
try and let us know whether it resolves the issue.

Thanks,
Baolin

