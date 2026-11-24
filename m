Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523013;
	b=FJ33ln+asNxvI02ogyTyUe81cGTOMBlZLZcJV/aZYlIKgVLoAV0Tt/syRvM/w5DW2MUB
	 F7A0DZWQuvi516K7+BJL8V9C+sm06elj3TFx5mh3NaKir8Sb0QXt4XepojJ+l4pn4HufQ
	 BX1qtf4ETMmlSOpxgmoTRfKurXbixuHlUUqNgUU5Gr8L4B09JQKxeir118yaSC6t+AcXu
	 1RfVp56WKXrII3Y4NQTSJdtZjNkAR1lkUqU6npztEekcTGUw3z73abN3fbAorMHjaDDZM
	 SN95FOFnTkAtW1nmH3swEw0gflK1loA0I/M7l6Fz/DbsvMEde7Ic8b69uEG90+Bw9Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523013;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WMWxmBhPP+n5wOgqOVE7tw+CE7q8Gql1PVHFDLs735c=;
	b=lxSWgwT6KHIm8asT5EbGY1ciUVs84Ck4ZCewi4rYyiKVu45n65XPHl/1Q3R7DqbsaVCf
	 CHOqrrggWasNed87GAzlV8mLItAItQPdOoZTgtv/H7z/Vbzy3qeNlN7QDl6ydY5BOJgNB
	 BFxLEq5xYytS3WGY/jsIXuhThITpqhHh4dc/txBNl2W3fdo/kSCR6d0BDbQDMe3aHcum8
	 axJNhLq2mdzT1J6+tAoL5NN4cLaFKOyOWTLsrPCqKe9X5eH8hUS03FsCIgHfj3Dwqf3uy
	 mstt5j9EwGcqU9VmTIO0EjQE2XBToIN9KQ4DRL9hwA0pVyxp0cm4r+vCJXtfw44zZSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952A606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0952A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d9ae566ce80111f19a56ed5b684f684d-20261124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:34fc09be-d74a-44f8-84c1-f45fd63422ab,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:867d302df267e885359b07b1e050cf77,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d9ae566ce80111f19a56ed5b684f684d-20261124
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1164414742; Tue, 24 Nov 2026 20:23:26 +0800
Message-ID: <cf36f35f-788b-462a-a83e-d9f6b22f006b@kylinos.cn>
Date: Tue, 24 Nov 2026 20:23:24 +0800
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
Subject: Re: [PATCH 1/3] virtiofs: fix use-after-free of fs->tag on device
 removal
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev,
 German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261105150943.86650-1-mszeredi@redhat.com>
 <20261105150943.86650-2-mszeredi@redhat.com>
 <656d0e00-01a6-4e90-a924-4ad2329c3d74@kylinos.cn>
 <CAJfpegsOCq4oGfxzYh=DdL5x2BxaWc=c-SnSi1SOOk4eDOooqA@mail.gmail.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <CAJfpegsOCq4oGfxzYh=DdL5x2BxaWc=c-SnSi1SOOk4eDOooqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

On 24/11/2026 19:53, Miklos Szeredi wrote:
...
>>
>> The fix for the UAF issue regarding fs->tag looks good to me.
>>
>> However, while looking at this, I happened to notice another similar potential issue: when the DAX mode
>> is enabled for file read/write, the DAX window is mapped via devm_memremap_pages and unmapped when the device
>> is unbound. Although as far as I know, the corresponding QEMU changes for DAX mode don't seem to have landed
>> in QEMU upstream, fs->window_kaddr and other established page table mappings still point to this memory region.
>> Perhaps we should also look into cleaning them up?
> 
> Please do.  Can I assign virtio_fs bugs found by sashiko to you?
> 

Sure, feel free to assign them to me. We are working on virtiofs-related stuff, 
and I'll do my best to look into them.

Thanks,
Li Wang

