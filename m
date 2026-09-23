Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043453E5ED1;
	Wed, 23 Sep 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154712; cv=none; b=Bgi2RdehfRjb3fRR2roOHhzH0SNs3fvRyD6xDIGeq5ZZG/KKL5fldZjFuPXaOgAyRoMegkPC4uTWBHx8femFSLozfiwjWDSFkkGHkBLOYQJ1cgMdggdtrsBoIVOzHkyfU/xxKO0dH0ZSoeLu95J7WJmmeJqICBn6gGsF/gLZaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154712; c=relaxed/simple;
	bh=T9XRrvSAfGcuaCP0QODty0SWDNSvcd3xqvc5gA3JcjM=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=LNW6EuesTeD+exmRHNuRumX4cSg5VZeR6oh0JEQ2ybo1aR8Hgxn/OD6HGw5RPnC8MYkc3AcRB3+8vqqxdFlMq4Kj16OD40nPb6W1B5xNYGBfAgOQtRtvHczX1fo8VYtsLwffpLlBENRPazXdkDa4tR/FgYwnReqcwemP7UkfLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=USLHUnUf; arc=none smtp.client-ip=115.124.28.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="USLHUnUf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790154702; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=T9XRrvSAfGcuaCP0QODty0SWDNSvcd3xqvc5gA3JcjM=;
	b=USLHUnUf2Qst2UDPx6RiSEx7IWIFXg7HDVrVJAt7FZr8Erpr01pzx12mIY5CvbrliUXxn1L8i2RyzqL9zunGPI4x2La5M/aA/YBWLat77r6tf/ncy/DOgzbcDLKJ+wp9UvqJJUTNq32Aaf/cVq0A9loBeTn/3M/mUwVOosIUbdg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3340757|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00396156-1.54303e-05-0.996023;FP=9709663845400433407|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=fangxy@xiaopeng.com;NM=1;PH=DW;RN=6;RT=6;SR=0;TI=W4_0.2.3_v5ForWebDing_21251800_1790151658933_o7001c467;
Received: from WS-web (fangxy@xiaopeng.com[W4_0.2.3_v5ForWebDing_21251800_1790151658933_o7001c467] cluster:ay29) at Wed, 23 Sep 2026 17:11:37 +0800
Date: Wed, 23 Sep 2026 17:11:37 +0800
From: "Fang Xieyan" <fangxy@xiaopeng.com>
To: "Doug Anderson" <dianders@chromium.org>
Cc: "jason.wessel" <jason.wessel@windriver.com>,
  "danielt" <danielt@kernel.org>,
  "kgdb-bugreport" <kgdb-bugreport@lists.sourceforge.net>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "stable" <stable@vger.kernel.org>
Reply-To: "Fang Xieyan" <fangxy@xiaopeng.com>
Message-ID: <f9f9770d-f3de-4d49-b5b8-7d79dcb2d758.fangxy@xiaopeng.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0ga2dkYjogRml4IGJ1ZmZlciBvdmVyZmxvdyBpbiB0aGUgJ00nIGFu?=
  =?UTF-8?B?ZCAnWCcgcGFja2V0IGhhbmRsZXJz?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260922154907.90535-1-fangxy@xiaopeng.com>,<CAD=FV=UDqPUAWw+h-t4Jkno0Sy0_2T8xfXZgfjsVMM1fTG3JkA@mail.gmail.com>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE1My4wLjAuMCBTYWZhcmkvNTM3LjM2La
In-Reply-To: <CAD=FV=UDqPUAWw+h-t4Jkno0Sy0_2T8xfXZgfjsVMM1fTG3JkA@mail.gmail.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgRG91ZywKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCj4gTXkgYW5hbHlzaXMgc2hvd3MgdGhh
dCB0aGUgYWJvdmUgaXNuJ3QgdHJ1ZSBhbmQgdGhhdCB6ZXJvLWxlbmd0aCAnWCcKPiBwYWNrZXRz
IGFyZSBubyBsb25nZXIgdmFsaWQgd2l0aCB5b3VyIHBhdGNoLiBJIGhhdmVuJ3QgdGVzdGVkIHRo
aXMKPiBteXNlbGYsIHRob3VnaC4gWWVsbCBpZiBJIGdvdCBpdCB3cm9uZy4KCllvdSdyZSByaWdo
dC4gRm9yICJYMCwwOiIsIHB0ciByZWFjaGVzIGJ1Zl9lbmQgYWZ0ZXIgcGFyc2luZyAnOicsCmFu
ZCB0aGUgYHB0ciA+PSBidWZfZW5kYCBjaGVjayByZXR1cm5zIC1FSU5WQUwgYmVmb3JlIHRoZSBs
ZW5ndGgKY2hlY2suIEknbGwgY2hhbmdlIGl0IHRvIGBwdHIgPiBidWZfZW5kYCBzbyB6ZXJvLWxl
bmd0aCAnWCcgcGFja2V0cwpyZW1haW4gdmFsaWQuCgo+IEkgZG9uJ3QgbG92ZSBtYWtpbmcgdGhp
cyBhIGdsb2JhbC4gQ2FuIHdlIGp1c3QgcGFzcyBpdCBkb3duPyAuLi5hbmQKPiBtYXliZSBmb3Ig
ZnVuY3Rpb25zIHdoZXJlIHlvdSBwYXNzIHRoZSBsZW5ndGggeW91IGFsc28gcGFzcwo+ICJyZW1j
b21faW5fYnVmZmVyIiBhcyBhIHBhcmFtZXRlciBhbmQgc3RvcCBhY2Nlc3NpbmcgdGhlIGdsb2Jh
bD8KCk15IHBsYW4gaXMgdG8gcGFzcyBib3RoIHJlbWNvbV9pbl9idWZmZXIgYW5kIHRoZSByZWNl
aXZlZCBsZW5ndGgKdGhyb3VnaCB0aGUgcmVsZXZhbnQgZnVuY3Rpb25zOgoKICBnZGJfc2VyaWFs
X3N0dWIoKSAtPiBnZGJfY21kX21lbXdyaXRlKCkgLyBnZGJfY21kX2JpbndyaXRlKCkKICAgICAg
ICAgICAgICAgICAgICAtPiB3cml0ZV9tZW1fbXNnKCkKCnNvIHRoYXQgd3JpdGVfbWVtX21zZygp
IG5vIGxvbmdlciBhY2Nlc3NlcyByZW1jb21faW5fYnVmZmVyCmRpcmVjdGx5LiBUaGVzZSBmdW5j
dGlvbnMgYXJlIGFsbCBzdGF0aWMgYW5kIG9ubHkgdXNlZCB3aXRoaW4KZ2Ric3R1Yi5jLCBzbyB0
aGUgc2lnbmF0dXJlIGNoYW5nZXMgc3RheSBsb2NhbC4KCg==
