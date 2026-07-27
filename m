Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12F2459C5;
	Mon, 27 Jul 2026 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137376; cv=none; b=C4hDR9h71VPjmjXLTFN3OuFjykYSCseQB/ugUBFk5Ouuhn9D/AO/tI3FRzc0XShzRLFnbHPLQvgZ7E+vFpXAZXZx9Z5JjywO6SrubhGUIosf5+FmuIOReDzIEGY//CBef7Tbpk4NethfzUurvIwlxQBry0kKVEfQU5nvSjV9EAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137376; c=relaxed/simple;
	bh=iHp6Wwzjr+kjsGGGHEint1pSI8BFOjcinEky6Wmxb+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=kVFZdwKjLt9g1x9MYjUMXkYPie7KCYZfdeV8JcZnM5GJbiUz+bnij40Dyu4sUws7QH7sZRwhqJlOIlWmovjGHmMm7ZoQJwDVDfBo1SbI6aBE5GTd7XkkdDblMvA0JlWMvhivMJm+O+WWDD5W5oyBDidyh6XQq069tiFunGLWkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RNNqYLyE; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RNNqYLyE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=iHp6Wwzjr+kjsGGGHEint1pSI8BFOjcinEky6Wmxb+8=; b=R
	NNqYLyEcQpSUbJX9w9epo7tryfVRZuQ+seiQdr9NLQWDA00B/jhINmbO4jJVjL5M
	9YSNRubpT75NlpzMHiXOd3gnOW+wGUShTcJCr1U/6vhZn1K+lnYCHiTrHERKF8S8
	/KtcKtkuGG9Wn601bxoKiMo2V0A6pFaVbiyslGnsWo=
Received: from w15303746062$163.com ( [115.53.140.219] ) by
 ajax-webmail-wmsvr-40-117 (Coremail) ; Mon, 27 Jul 2026 15:28:14 +0800
 (CST)
Date: Mon, 27 Jul 2026 15:28:14 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: "Greg KH" <greg@kroah.com>
Cc: simona@ffwll.ch, deller@gmx.de, tzimmermann@suse.de,
	ville.syrjala@linux.intel.com, sam@ravnborg.org, kees@kernel.org,
	yanquanmin1@huawei.com, syoshida@redhat.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: Re:Re: Re:[PATCH 7.0] fbdev: fbcon: fix memory leak in error path
 of fbcon_do_set_font()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <2026072719-kissable-antonym-d31e@gregkh>
References: <20260525082741.600003-1-w15303746062@163.com>
 <5b288246.378d.19e95d82602.Coremail.w15303746062@163.com>
 <726d129f.53bd.19fa2601661.Coremail.w15303746062@163.com>
 <2026072719-kissable-antonym-d31e@gregkh>
X-NTES-SC: AL_Qu2TB/2YuEoi4iWZbOkfmU0Qguw9Xcq5uPkj34FWN5t8jD/p6wkiclhFBGTN39q/NymWkiiSQiFv8MdmQoVpcpIopIfFY9aPchD3PhnA6ksdFA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <39aeae7d.5bf9.19fa2796cc0.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dSgvCgBHFxmOCGdqSxwmAA--.8533W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4w6ZfWpnCI75RgAA39
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

Cj4KPldoeSBub3QganVzdCB0YWtlIHRoZSBzYW1lIHVwc3RyZWFtIGNvbW1pdHMgZm9yIG9sZGVy
IGtlcm5lbHMgYXMgd2VsbD8KPgo+V2hlbmV2ZXIgeW91IGRvICJvbmUgb2ZmIiBwYXRjaGVzIGxp
a2UgdGhpcywgaXQgbWFrZXMgYmFja3BvcnRpbmcgZnV0dXJlCj5jaGFuZ2VzL2ZpeGVzIGFsbW9z
dCBpbXBvc3NpYmxlLCBhbmQgd2UgYWxtb3N0IGFsd2F5cyBnZXQgaXQgd3JvbmcuICBTbwo+YmFj
a3BvcnRpbmcgdGhlIHNhbWUgY2hhbmdlcyBpcyBhbG1vc3QgYWx3YXlzIHRoZSBiZXN0IGlkZWEu
Cj4KPkFsc28gbm90ZSB0aGF0IHRoZSA3LjAueSBrZXJuZWwgaXMgbG9uZyBlbmQtb2YtbGlmZS4K
PgoKRnJvbTogTWluZ3l1IFdhbmcgPDI1MTgxMjE0MjE3QHN0dS54aWRpYW4uZWR1LmNuPgoKSGkg
R3JlZywKClVuZGVyc3Rvb2QuIFRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uIGFuZCBmb3IgbGV0
dGluZyBtZSBrbm93LgoKSSB3aWxsIGRyb3AgdGhpcyBwYXRjaCBzaW5jZSA3LjAgaXMgRU9MLCBh
bmQgSSB3aWxsIG1ha2Ugc3VyZSAKdG8gc3RpY2sgdG8gdXBzdHJlYW0gY29tbWl0cyBmb3IgZnV0
dXJlIGJhY2twb3J0cy4KCkJlc3QgcmVnYXJkcywKTWluZ3l1Cg==
