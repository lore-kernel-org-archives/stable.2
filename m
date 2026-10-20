Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502781;
	b=J22RguzFT/wZJDnF7O+tcn7jRhswuz6fLIuG/aByUStDxTQ0ExZLWJSh/2PSA7cDmfEG
	 PWH8wr2LalbXt7EyroAvxUZwuLzwekdvKHaMGYE6eR9jCigvJqQvYbBbAuYx0c5SrBIAx
	 c8V2jPGl4Z8/IZnkcV0FQCzcDuocmojZUYBtpWde8ioXGZXsQnIX94z5VIE8H8CsMUo6l
	 aELKKSoz3FxmkVpfNrX5nQL0H0DdxQqUCZpz/lvPvDeJyIU0cFyJqyXS145qnQOs7Hhz2
	 J8seNgl2niDe/mbthLkPZCjLokAqJYO2Bh1h6iB9UjIRBNUXJSroJTyV33wXPXxrAJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502781;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PaW5pQEkT5mohB48XjKoLGf8/2YWFkvULX8VqVDxB7A=;
	b=3e1PBhZ4OXGzzSaivdGmhjd+CezFOOYPwuqy6nrKjQJApQXwmDNySKSYR/o5ncW8tCbl
	 NBcQKqAjCfsAnEbgy0+6TnzySb0Npf69chgTKaBHaD5x4o7Tn1UIYfcf+g0hxsnRqWgnY
	 Ue1du/N7fOXxnTJrXZhyd+ubgElIUHpTchawMnDYP4kGaiw/anGJMjUONuNSmmYTS/gsk
	 DdwqN74qBSMA88WTykO8aF/v8mKpEKvwxTduODnbPyZHfXhEpwkt8YQCrfJ4GIkXY/9sS
	 j0a1tUWUDhk7vQJ18bLTBzv1IPmg1KrgoiEu58hO/qezaSeCpyN7mUgPMjZEoIfRHhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FhjmhN+i;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="H/mvXxUQ";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C1606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F3C1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FhjmhN+i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H/mvXxUQ
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDAJVC2214644
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PaW5pQEkT5mohB48XjKoLGf8/2YWFkvULX8VqVDxB7A=; b=FhjmhN+iB8MJmVBY
	xrTJdxO16ebB5m/+aYgPFjCujUMITQK4uZgY3YcE3TBdUaYi1KB/Y6PhGBIATqiJ
	e2TxVMhcmLP/xXcxee6joWZQTkOU/JhmOIZVl3blD+OUKPK15OW22ZdDoZJfiogy
	h2PTZrpNFgZSP6j5hrsBJUrvvEPT9FjXTY7HHCgC/jESNkdi66hecgdmkR9RJmCf
	9Wi0HI+UKkYcmAZdIyh1l3X0YOHFFwMIhy2FHMbMfXkisG6Ao3CRZfCvyod5SVAJ
	9Qj0HVhgPC83F9ggHURksP5EWx7zSJRMFKab0IgGQwAxXGF9832zuSbuXfwEXZjn
	uhIsIA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5ntjpc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:26:20 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7cc694cb4adso274345137.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502780; x=1793107580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PaW5pQEkT5mohB48XjKoLGf8/2YWFkvULX8VqVDxB7A=;
        b=H/mvXxUQ7yG2Gn4LpWL20UNfL3I+UAZYJYxhPT9cCDEzna4z7iRW0017GEsQ0bybux
         cjf7HUAEwtBDw7S4IIJycZ/Uq+s5Vg4k93gDX+ZLrgabcS/17XhJNu3WBNqZe4vK8/fB
         ycXzlfUKEKxK0fS/dUWp/av/fCtajpY8c9lgBbMxJUzHqRo38JfZ6Y9G+xSHzIUIbde6
         icXR+lJLbm2AvcpX4zdNrs2gSkHHjnqYlGV89U0eR9C6lx+T8uGJTvb703ibL8aa/Xdr
         SgWaPx2JFF40io5cbuoNB9yoDmHIeMd6zTuh2/W77qKhIuBm5kw1Ch3maolpZ4ajFxwV
         3snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502780; x=1793107580;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PaW5pQEkT5mohB48XjKoLGf8/2YWFkvULX8VqVDxB7A=;
        b=oxOFLJPzo49Nl2WYLhwiZGtpQe1CuKVolSBlbE+OfbGfjtSWYsGYbjfqKEcZkdP+5S
         cN8npArtj4MgfinwPjh22wASKqzHD6KC2osXGAcI4cTL8+wEme7a1xqHhwlN7fG1WqkU
         eiZLJUa7NPcY/be4NzAu8KUnRyWRPpSp7OJRlcT31a6Z0KmfoLc6ZAAVgCEfnoaDrblV
         6ejQHGKjAFhqf7+6Aukv70UO+gRhaQc7i1f0yz+1e/ARixg1bWaoSiIijY3PJjeKBWYP
         vs4dGMBlMpbVm9gLsyhkBc0Agek19+fqrfQgFXUlETOfEBrqG1Y5onE44ODN8zvKOY6t
         FcGw==
X-Forwarded-Encrypted: i=1; AKwUvBzaV9EXBu5DGoBMBbCes/RcCUF/eA2yT2OOgTDX6DdUtpwQtxsp6rdHbBhGQkqTpkE4LeLRVAk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7FTMM/a+VEAJh+xfMZTFD4XjP+QTp3ykZOvBRlPQTQY+DY3JH
	NXmK22u4tEuQMbzt32vKxfrXzY/5TYynSgo9PXoPibW2+JoOrZLVA5b4Ul0Th1l0uAIJY6yWDcj
	2BNl6FSBENbFW2zK9N8LtlfatFXjdwHE3DuKbOm1OO/8KeiEI+JzmuN1i8TA=
X-Gm-Gg: AYBFou0fs2rR8oERGGWf1FPw9OfyXmZXNACcLWf6U8ihoiFH7TC26IddxhtlRMmM6M4
	XJ1jUJ7qM7W+T3+F3c/1NLdmecGESyHQL0FHOzjl0qFOSNEm/bnuu67CqT9FfAmGablQkfxSGIe
	S6U6hPbPZJkrAR07ukuyUxlNrrqo/i+JZ1NgEnMVHRTtAoBjI31CAg9HveELwa0b3enOabYkyVX
	nV/p81m1PfdZRQCqqRrK7I3KmdOzYvtjj/fZcCqVkZ1IxUHUd2WipDV4WiHYMtJGH7OdnmQdh2H
	a6GOBVNKOY7bCbtXZpZYM9PW2sPpdL9f36TRAr8vtvcC1UIo7PU2Ha5TGY5CDYT0Q6T1XTFoNuT
	4WMj/fFUGnEmvzx+4GSiR+OBn5JI=
X-Received: by 2002:a05:6102:955:b0:7cc:23e7:e74a with SMTP id ada2fe7eead31-7cc3695dfe9mr2282382137.14.1792502779530;
        Tue, 20 Oct 2026 06:26:19 -0700 (PDT)
X-Received: by 2002:a05:6102:955:b0:7cc:23e7:e74a with SMTP id ada2fe7eead31-7cc3695dfe9mr2282369137.14.1792502779040;
        Tue, 20 Oct 2026 06:26:19 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d1e8ebsm67021575e9.3.2026.10.20.06.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:26:18 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH] gpio: pca953x: Preserve wakeup accounting on parent IRQ failure
Date: Tue, 20 Oct 2026 15:26:16 +0200
Message-ID: <179250277086.33804.10505496122587377606.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018161042.3298045-1-sahaj123.sc@gmail.com>
References: <20261018161042.3298045-1-sahaj123.sc@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfX3WzYoE1PC41G
 S0JzpVLwhCpuFh7JHY04QWdsWxfAjBMA1VDVsAGD8GS+62QLqsypkEPOmP3qwfe7FX8GoG1rqtW
 VkP0UVf1M7/h7Fx3+YVnoOoYGq602nE=
X-Proofpoint-GUID: 85JxwjCNn3wpbnQ340SPIIQ5rNdUCm5V
X-Proofpoint-ORIG-GUID: 85JxwjCNn3wpbnQ340SPIIQ5rNdUCm5V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfX7KFGKqnWFhHl
 b3eHHRTtUdn8wf5vu8oQW4T2gM8jV09/9qgPkAbLOj86Jz0hCXRAQxXjBM0iGJn2P/TWAwCrWBD
 /cgCCmzVH2mgVlmE7+eFCjBvMYOObaLmTHm7KEi9oKt92oqcwMwA/hOCQCeHnIxt7PV1kjTFo/6
 yXcINhrELCGgZpUL3ol17s0hZ9AiuJ8dARVWsxVUfYYrUa6MwyV7zWyuDmIikD6b5Uizq6BLiip
 HieRCnhsR9/p/et2ufztE5lVJj7Q9s70jB8RPPlWuog/zXn2BfH9EjEvcjpGxN2+9eywcUUXtPA
 NN90IJ3j8o5rjF3vUd0Rl8SkpstznufciSdZ42WFWU2O6lpajkLBp+iE6V7H+1j7V+11rmb/fzz
 9vKk2GE9K52pxpYOqmA5To0h55bejf61wf3ELEqzGGs8GO4MQZXgQNVDpRLT00jgNV8Mpz/m38D
 2ApH1rmxe+LD5odoYLQ==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad76bfc cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_G_FQYvs2ls0BvL-ThMA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200053


On Sun, 18 Oct 2026 21:40:42 +0530, Sahaj Chaudhari wrote:
> pca953x_irq_set_wake() updates wakeup_path before asking the parent
> IRQ controller to change its wake state. If irq_set_irq_wake() fails,
> the IRQ core rolls back its wake state but the driver's counter remains
> changed.
> 
> A failed enable can therefore leave the expander marked as part of the
> wakeup path when no child IRQ has successfully enabled wakeup. A failed
> disable can make the driver stop retaining power even though wakeup is
> still enabled. The suspend and resume paths use this counter to decide
> whether to disable or enable the regulator.
> 
> [...]

Applied, thanks!

[1/1] gpio: pca953x: Preserve wakeup accounting on parent IRQ failure
      https://git.kernel.org/brgl/c/a38bf551726a21c9bcc001b02164f30378b64b64

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
