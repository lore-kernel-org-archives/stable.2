Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3413A1CD;
	Mon, 27 Jul 2026 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135169; cv=none; b=axXK2LZpl2qTd+iwRgDpsnKciEQdz+XINfTp94wVtZiETIUSkhaKpvA9p1pVPpkI4EuOGdpbEKGnBej9T3Cpwa44whOfD+x2SQ3TCVthknqP1pmMkS4FFEq50pbUpdSX0x0dNgSGOxHiVp4NwstaAmFxV7oLdGKNdY9zU6fPUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135169; c=relaxed/simple;
	bh=9mLQ6594NbnJ0IngZKBIu4YernNv5qY4NeX/DazPvIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=LykyJlXVvq4hKZQkZF9zxk/zMhYRUMjyGM02m/0Kyj0kwSwfyFc46s2HtQHKculySip0LAfj+ZcR8X8jtuRTDthixBuZgeIXZF0puuEtxdy4d6Kg44dEv8VwEXK1sJI0yrnnIVqyOEEpyMV6dI8SEKtbSkPiZjJK6tnXmcdWjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cxnVPjjM; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cxnVPjjM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=9mLQ6594NbnJ0IngZKBIu4YernNv5qY4NeX/DazPvIo=; b=c
	xnVPjjMbL6849Iq47Zc/GJUMIgjh2DDZ0JMKUNAs12+mS8iWQ7NbZocmE55Lsu3v
	XMGSosC2KHP7XW6qHryk0CdE53x0cbWHWwXU/kl4XL48Eaz9JLS+dCLoduPUwyH5
	Gpz/P/cRF94zJRwPO03KiBc/njLxHfrEoA2OdyF18Q=
Received: from w15303746062$163.com ( [115.53.186.73] ) by
 ajax-webmail-wmsvr-40-117 (Coremail) ; Mon, 27 Jul 2026 14:51:34 +0800
 (CST)
Date: Mon, 27 Jul 2026 14:51:34 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re:[PATCH v2] drm/vblank: Reject 0-period timers to prevent
 hrtimer storm
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <33239270.5344.19e9683e439.Coremail.w15303746062@163.com>
References: <fa91ccc0-7660-44fc-92a8-ab569ebe3a7c@suse.de>
 <20260523025447.581709-1-w15303746062@163.com>
 <33239270.5344.19e9683e439.Coremail.w15303746062@163.com>
X-NTES-SC: AL_Qu2TB/2Yukgi4iOeYekfmU0Qguw9Xcq5uPkj34FWN5t8jD/p6wkiclhFBGTN39q/NymWkiiSQiFv8MdmQoVpcpIoX4F64kEUq2/pILHSYTgZ4w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <238fcbf9.514c.19fa257da64.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dSgvCgBXdnH2_2Zqzw0mAA--.8537W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4xZxVWpm--Y-5QAA3O
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKSGkgTWFhcnRlbiwgTWF4aW1lLCBUaG9tYXMsIGFuZCBhbGwsCgpSZXNlbmRpbmcg
dGhpcyB2MiBwYXRjaCBhcyBpdCBoYXMgYmVlbiBhIHdoaWxlIHNpbmNlIHRoZSBzdWJtaXNzaW9u
IAooTWF5IDIzKSBhbmQgbXkgcHJldmlvdXMgcGluZyAoSnVuZSA1KS4gCgpUaGlzIHBhdGNoIGFk
ZHJlc3NlcyBhbiBocnRpbWVyIHN0b3JtIGFuZCBSQ1Ugc3RhbGwgaXNzdWUgaW4gdGhlIERSTSBj
b3JlIAp0cmlnZ2VyZWQgYnkgbWFsZm9ybWVkIHVzZXJzcGFjZSBkaXNwbGF5IG1vZGVzLiBTaW5j
ZSBpdCBqdXN0IGFkZHMgYSAKc3RyYWlnaHRmb3J3YXJkIHNhbml0eSBjaGVjaywgdGhlIGltcGFj
dCBvbiBleGlzdGluZyBjb2RlIGlzIG1pbmltYWwuCgpDb3VsZCBhbnlvbmUgcGxlYXNlIHRha2Ug
YSBsb29rIHdoZW4geW91IGhhdmUgYSBtb21lbnQ/CgpCZXN0IHJlZ2FyZHMsCgpNaW5neXUKCj5B
dCAyMDI2LTA1LTIzIDEwOjU0OjQ3LCB3MTUzMDM3NDYwNjJAMTYzLmNvbSB3cm90ZToKPj5Gcm9t
OiBNaW5neXUgV2FuZyA8MjUxODEyMTQyMTdAc3R1LnhpZGlhbi5lZHUuY24+Cj4+Cj4+RnV6emVy
cyBsaWtlIFN5emthbGxlciBjYW4gc3VibWl0IGV4dHJlbWVseSBtYWxpY2lvdXMgZGlzcGxheSBt
b2Rlcwo+PnRocm91Z2ggRFJNX0lPQ1RMX01PREVfU0VUQ1JUQy4gSWYgdXNlcnNwYWNlIHBhc3Nl
cyBhIG1vZGUgd2l0aCBhCj4+bWFzc2l2ZSBwaXhlbCBjbG9jayAoY3J0Y19jbG9jaykgYW5kIHNt
YWxsIHJlc29sdXRpb24gKGh0b3RhbC92dG90YWwpLAo+PnRoZSBpbnRlZ2VyIGRpdmlzaW9uIGlu
IGRybV9jYWxjX3RpbWVzdGFtcGluZ19jb25zdGFudHMoKSB0cnVuY2F0ZXMKPj50aGUgcmVzdWx0
aW5nIGZyYW1lIGR1cmF0aW9uICh2YmxhbmstPmZyYW1lZHVyX25zKSB0byAwLgo+Pgo+PldoZW4g
dmlydHVhbCBkaXNwbGF5IGRyaXZlcnMgKHN1Y2ggYXMgdm13Z2Z4IG9yIHZrbXMpIHJlbHkgb24g
dGhlIERSTQo+PmNvcmUncyBzb2Z0d2FyZSB2Ymxhbmsgc2ltdWxhdGlvbiwgZHJtX2NydGNfdmJs
YW5rX3N0YXJ0X3RpbWVyKCkgaXMKPj5jYWxsZWQuIEl0IGJsaW5kbHkgY29udmVydHMgdGhpcyAw
LW5zIGZyYW1lZHVyX25zIGludG8gYSBrdGltZSBpbnRlcnZhbAo+PmFuZCBzdGFydHMgdGhlIGhy
dGltZXIuIEFuIGhydGltZXIgd2l0aCBhIDAtcGVyaW9kIGZpcmVzIGluc3RhbnRseSBhbmQKPj5j
b250aW51b3VzbHkuIFNpbmNlIGhydGltZXJfZm9yd2FyZF9ub3coKSBjYW5ub3QgYWR2YW5jZSB0
aW1lIGZvciBhCj4+MC1wZXJpb2QsIHRoZSBDUFUgZ2V0cyBsb2NrZWQgaW4gYW4gaW5maW5pdGUg
aGFyZC1JUlEgbG9vcCwgc3RhcnZpbmcKPj50aGUgc3lzdGVtIGFuZCBjYXVzaW5nIG1hc3NpdmUg
UkNVIHN0YWxscy4KPj4KPj5GaXggdGhpcyBEb1MgdnVsbmVyYWJpbGl0eSBieSBhZGRpbmcgYSBk
ZWZlbnNpdmUgc2FuaXR5IGNoZWNrIGluCj4+ZHJtX2NydGNfdmJsYW5rX3N0YXJ0X3RpbWVyKCkg
dG8gcmVqZWN0IGEgMC1ucyBmcmFtZSBkdXJhdGlvbiwgYWxsb3dpbmcKPj50aGUgRFJNIGNvcmUg
dG8gZ3JhY2VmdWxseSByZWplY3QgdGhlIG1hbGljaW91cyBtb2RlLgo+Pgo+PlNpZ25lZC1vZmYt
Ynk6IE1pbmd5dSBXYW5nIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4KPj4tLS0KPj5D
aGFuZ2VzIGluIHYyOgo+Pi0gTW92ZWQgdGhlIGRlZmVuc2l2ZSBjaGVjayBmcm9tIHZtd2dmeCB0
byBkcm1fdmJsYW5rLmMuIFRoZSB0aW1lcgo+PiAgbG9naWMgd2FzIHJlZmFjdG9yZWQgaW50byB0
aGUgRFJNIGNvcmUsIHNvIHBsYWNpbmcgdGhlIGNoZWNrIGhlcmUKPj4gIHByb3RlY3RzIGFsbCBk
cml2ZXJzIHJlbHlpbmcgb24gdGhlIGNvcmUgc29mdHdhcmUgdmJsYW5rIHRpbWVyLgo+Pi0gRHJv
cHBlZCBXQVJOX09OX09OQ0UoKSB0byBwcmV2ZW50IHVucHJpdmlsZWdlZCB1c2Vyc3BhY2UgZnJv
bSBlYXNpbHkKPj4gIHRyaWdnZXJpbmcga2VybmVsIHBhbmljcyBvbiBzeXN0ZW1zIHdpdGggcGFu
aWNfb25fd2FybiBlbmFibGVkLgo+Pgo+PiBkcml2ZXJzL2dwdS9kcm0vZHJtX3ZibGFuay5jIHwg
MTAgKysrKysrKysrKwo+PiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Pgo+PmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX3ZibGFuay5jIGIvZHJpdmVycy9ncHUvZHJt
L2RybV92YmxhbmsuYwo+PmluZGV4IGY5MGZiMmQxM2U0Mi4uYjM4ZDBiMzBhNjUxIDEwMDY0NAo+
Pi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMKPj4rKysgYi9kcml2ZXJzL2dwdS9k
cm0vZHJtX3ZibGFuay5jCj4+QEAgLTIyNDEsNiArMjI0MSwxNiBAQCBpbnQgZHJtX2NydGNfdmJs
YW5rX3N0YXJ0X3RpbWVyKHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKPj4gCj4+IAlkcm1fY2FsY190
aW1lc3RhbXBpbmdfY29uc3RhbnRzKGNydGMsICZjcnRjLT5tb2RlKTsKPj4gCj4+KwkvKgo+PisJ
ICogREVGRU5TSVZFIENIRUNLOgo+PisJICogZHJtX2NhbGNfdGltZXN0YW1waW5nX2NvbnN0YW50
cygpIHRydW5jYXRlcyBmcmFtZWR1cl9ucyB0byAwIGlmCj4+KwkgKiB1c2Vyc3BhY2UgcHJvdmlk
ZXMgYSBtYWxpY2lvdXMgbW9kZSB3aXRoIGEgaHVnZSBjcnRjX2Nsb2NrIGFuZAo+PisJICogc21h
bGwgaHRvdGFsL3Z0b3RhbC4gUHJldmVudCBhbiBpbmZpbml0ZSBoYXJkLUlSUSBsb29wIGZyb20g
YQo+PisJICogMC1wZXJpb2QgaHJ0aW1lciBieSByZWplY3Rpbmcgc3VjaCBtb2Rlcy4KPj4rCSAq
Lwo+PisJaWYgKHVubGlrZWx5KHZibGFuay0+ZnJhbWVkdXJfbnMgPT0gMCkpCj4+KwkJcmV0dXJu
IC1FSU5WQUw7Cj4+Kwo+PiAJc3Bpbl9sb2NrX2lycXNhdmUoJnZ0aW1lci0+aW50ZXJ2YWxfbG9j
aywgZmxhZ3MpOwo+PiAJdnRpbWVyLT5pbnRlcnZhbCA9IG5zX3RvX2t0aW1lKHZibGFuay0+ZnJh
bWVkdXJfbnMpOwo+PiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdnRpbWVyLT5pbnRlcnZhbF9s
b2NrLCBmbGFncyk7Cj4+LS0gCj4+Mi4zNC4xCg==
