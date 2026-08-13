Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB328315D;
	Thu, 13 Aug 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588229; cv=none; b=oQtfJ5y2IE2HDXCAhlySF7rBiOqdbAqEw+wcngP5DVeQ9XUM72t95zWFHeJ3fNdun23/M5SJevVx2L3hTowQnUWg6nRsp1ysoNUdlje9IIqsT59siJje2wU5KU2D2W1hYLR2TDzrLXr8D7CjDY3R/7djsE4coAKVJL8lV4ip+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588229; c=relaxed/simple;
	bh=W7gk/5CUn5HfspyvfuqOqFjVbHTVdbkS7G22rQvyL8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuhkayLVEVepngHS6EuXX5H//YEWH4Kt8B4CeaqWT0G3eEnlhkNr3t9z1WGF8oolp+uMoFXxMyyWoSpbrrJxdAbP++fLEFbLIeJ2RiZtqD4OhEJCdW+W+ftWFf1tsOEgBLnvFQkBvkPzC9eR2ITQr1L7JELpcxXsPDowEAc4dtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e94d988896be11f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bc36ddf7-17e3-4ca7-972f-1ec92ae09724,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:610e7a24874f7a441ed3247224c58302,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:0|15|52,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e94d988896be11f1aa26b74ffac11d73-20260813
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 304537387; Thu, 13 Aug 2026 10:30:12 +0800
Message-ID: <00cf942e-4e0e-43b6-b4fb-3dc1e50a158a@kylinos.cn>
Date: Thu, 13 Aug 2026 10:30:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: block2mtd: Fix divide error when erase_size is
 zero
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: joern@lazybastard.org, richard@nod.at, vigneshr@ti.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com,
 =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@barelysecure.org>, stable@vger.kernel.org
References: <48230456575d27aa83ce8640de8fc07cc62e8efb.1786499433.git.xiaopei01@kylinos.cn>
 <871pc3msar.fsf@bootlin.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <871pc3msar.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/12 20:34, Miquel Raynal 写道:
> On 12/08/2026 at 09:52:42 +08, Pei Xiao <xiaopei01@kylinos.cn> wrote:
> 
>> The erase size is parsed from the "block2mtd" module parameter and can
>> be set to zero. add_device() then evaluates
>>
>>         if (size % erase_size)
>>
>> with a zero divisor, which triggers a divide error:
>>
>>         divide error: 0000 [#1] PREEMPT SMP PTI
>>         RIP: 0010:add_device drivers/mtd/devices/block2mtd.c:296 [inline]
>>         RIP: 0010:block2mtd_setup2+0x592/0xda0 drivers/mtd/devices/block2mtd.c:459
>>         Call Trace:
>>          block2mtd_setup+0x27/0xe0 drivers/mtd/devices/block2mtd.c:476
>>          param_attr_store+0x214/0x310 kernel/params.c:589
>>          module_attr_store+0x65/0x90 kernel/params.c:904
>>          kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
>>          ...
>>
>> Reject a zero erase size before performing the modulo operation so the
>> existing "erasesize must be a divisor of device size" error path
>> reports the invalid argument and frees the device.
>>
>> While at it, drop the unnecessary (long) cast from the size operand of
>> the modulo.
>>
>> Fixes: ea6d833a3fdd ("mtd: block2mtd: check device size")
>> Reported-by: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/lkml/6a7b58ba.ac361c09.22ff0a.0045.GAE@google.com/
>> Suggested-by: Jörn Engel <joern@barelysecure.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> 
> Apparently, removing the cast leads to an unsupported operation with a
> 64-bit operand on 32-bit architectures (See Sashiko report).
Using i386 for testing does reveal compilation issues; I will retain
this (long) cast and send the third version of the patch.

make ARCH=i386 -j$(nproc)

ld: drivers/mtd/devices/block2mtd.o: in function `block2mtd_setup2':
block2mtd.c:(.text+0x315): undefined reference to `__moddi3'
make[2]: *** [scripts/Makefile.vmlinux:72：vmlinux.unstripped] 错误 1

> 
> I guess it is best to keep that cast in the end.
> 
> Sorry for the changes back-and-forth.
It is my pleasure.

Pei.
> 
> Miquèl

