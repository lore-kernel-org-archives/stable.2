Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71F44C66C
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514922; cv=pass; b=qFSuwKjAz3h5N1iSRrjd0ZdOgjoc0lA7cPbhCLsyGJG2CSYGVE9uWx1ei/ncgg4MVkc4YyL93B10bV/mFb5dxq/Fmb5yOZ0m+I/Tcl5oyWHtPHYIniCReIkgEuNLNxuBOGndx6O5nkyyT4OgPstTA0n58jXy7S4SbKmHtjwfCts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514922; c=relaxed/simple;
	bh=zu7emRKboLzHXzyXbEcjLUBn53PCvlKoXemd+/irgw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RR3ePNackALNfkqsPyuh3qi35NnyFcGeplwK1mrj51o4g5O/5PxuqjNyyoeLsHg1YUpH84O1TALGo37k9TEgDEkX1kYw+rRB/4EnmgIT0LIQlbscJ0Wd03EbWz6FtWHmjrl1vS7L/Bx1LThkizRFZMwNtn9OYBiSfXhYCfKS+mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NNWooOyY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RyDT/8MK; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NNWooOyY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RyDT/8MK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847n4CA2431414
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 09:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MymcqnZkHOqjUJcCaTmpmg9eKweEy9UxXP0OOYlsdYI=; b=NNWooOyY48IabF6h
	3KcJixiMdydZRJXN8MGlW/Vns1nXSqMnNboKvm3FVCX1gk/MYu8ftA7HhKPj3HkK
	KX1Dm0P/Jbh+pQ5tmhVDELDu8xZx3UTYHNgerZCd96PbmiiepMW9jaLNrGkBiKvZ
	wO7sgch6Hm0Ea5oHpkCX1u/2fz+Y4rxp0M05Pe4Q0Nq6BWdK5y6Lg1RahFvtchbB
	2FNqTkOxiuCZanqSop7wfwN+c2vS6woWA54JtXJOEbo6UzVedCRkxOEZD8uJi+Ek
	H+c6JmDzsrJW4GiZcHy7Mu1Qz2+Tty9VwmGJsYXlQwUwn4z7tczYYX00DIuatwJQ
	kjRycQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfk921m39-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:41:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e375d9736so774741b3a.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514919; cv=none;
        d=google.com; s=arc-20260327;
        b=igFc2uRIqZxlKzt6D8KjFb3v8xzZov+uhF4eeBovDa8vjXwrVzS4NCRPk2wdXZSURD
         OpoVVjH628b1IiUQpcFHU9gDOkpNt3MBXvLCZqjGDLR7yR40hdoKu/5fvEFr24lQFrX/
         2EBxZfcU1Dckxs/1D13+q3wS41b9DV3RvLo8S0oWFj76pDR9mS0XuWERWg3zwVK7XtTK
         bHWKu11Tj2TcSR4bNCFSki4Mj52pWrq1IJqna4SB8+aHkXwHYHwavtdJu/njlDOLZou9
         hXy9tLe1Wbv3Nc7nju++0a/9Ushj9MXlcSKDDzgCRykKvYtDHkZK4QJuxh8noEp2bmUg
         nb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MymcqnZkHOqjUJcCaTmpmg9eKweEy9UxXP0OOYlsdYI=;
        fh=p8YJEGTCM+98bnRW3TGUVGc2gcgRgudlrzEh0ltHZQE=;
        b=R+EeIJOjMYrCa9PIPo+kMvA0Uu6R+AiDE2w01EksTabSY+3QPv9VySGfnSno3SmGrz
         /uMrVKzqV1eWk4an/z01S7JRzo8VgSDFDcu3SdBnHAFRUriFkxuEUrtAuHCZ5AD9LyGO
         3mo5N224hvVqUxujhIxPQfPBhhwYVuoxgx3+dWGMW6bf0zD/19TkakuTZYCW6VOr6rcL
         wy2tzMIU2oWl8afXNq4ESmEj+4bAC83p32GaNExgmz1wtc32lyueYL4qUc6MgYaqJRdb
         OsDVx6nytHYjBb4WT0sHh65tB0FaELUQOSYTuZvQoAU7TAUoyXIRcKMGPksClm4vQRSF
         N4Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514919; x=1789119719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MymcqnZkHOqjUJcCaTmpmg9eKweEy9UxXP0OOYlsdYI=;
        b=RyDT/8MKoEkDnaWBrCz29P/QGTipLbDhtmiGv2nNCdr1cvCFY8AnA/H50+Q+9DPDT0
         EhsR329e+C2hMEhYz0eaaYtg8BICLyxvXDTMspHh2J+FVZW67gzCPrpaelnbHjUdHuOp
         sm6C1Hl3oLYmXg6PP8vS6hx7cvvgx/ZIAMA9KKKfnqePFDy2cPaIoZfSRoabqf9nS/m/
         tCyT1QylgPsq81q9yVzBH1O8cM7lQhLnGDNcj1unYi0mxF2+GcRVRCw0iH8ZzGQubXfi
         ZB8VFIyHSXUS8/WXqztXLfmZOAX82OyLaVZhSXAipsAs521LLfZqsCurDooxtmFuZsze
         UHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514919; x=1789119719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MymcqnZkHOqjUJcCaTmpmg9eKweEy9UxXP0OOYlsdYI=;
        b=oOHwOnKMZgdRBZFoUCkC3YQIleNaKfqEbfMpsSzhgQb8Hf06S7VR8o29Rm8pRwItdy
         FzV4FQdwMHsExzjsznkQ9TWcgh6AIxqogo66Kk20m5jzHgFw3mCdxe+FplKK7qLgmve0
         pVhhBdyOigO5vc5Aa0A3f/IbXF0FR2c1O/2L8kBjCs9IpFCSB9El/veXSTJs7/Y9hqlQ
         /2N3wTVmXP44d2tX8rvV713oEjNYjDHBVwGtgLoPrqiOTRRojzCQWEBNGW9kHd83JJJM
         biVlcPUaCIO26pGeZ24u64+l8U5I7yWUZSIVQ7IMjkJ+Q/1UaW5K8RXVXh8fgeWMIogh
         XpHA==
X-Forwarded-Encrypted: i=1; AKwUvBzAHL0Oncn7RI6VSbxoA9MsuvS8h75WpaYaXeOcGC1mVpRCWfcx8JuohZ3ssJoeJbXDSoC0178=@vger.kernel.org
X-Gm-Message-State: AFuF++k6YGbMRDnJ4yXV7Ba4Lt/11aAftnCoJn0QImCkJi/P/+o1pyWG
	sNq4vfDatcZAxGqYgD3FPpBYzBO+CGTApfiAQHzEyrumbyJZ4nsXkqI5iv8ahC06IVu5Sn78ID7
	g1g0FSjNeOWXfi/xgkyNzz22u25DdMLV48IrI4zfXBa7P2Zfdv4MXD6UJiQwSt3/O/4Atx/MTr9
	SvLf/SMdcyPL9D7Sdnyr28+AMqJePytN3gvA==
X-Gm-Gg: AYBFou0Ql/3A7zSYl6Uct9ZZAky+G/HLYyqzgOeQWLiFMnhYdoGd/biWkBIH+0f4jGe
	PH0Z+g0TPodWsXuSWpgIOsNqB9xKe2n0yedd064IAuDt8ry9JnnXMIzach7iVXkDt1iL4n5PMSR
	Szc18kKRrfTa5ASt9vPF4mgCcImuYIFziMU46E341JtvTJlnep8wDUTOdEnA==
X-Received: by 2002:a05:6a00:400e:b0:84e:e741:174f with SMTP id d2e1a72fcca58-861669c6df9mr7906447b3a.7.1788514919160;
        Fri, 04 Sep 2026 02:41:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:400e:b0:84e:e741:174f with SMTP id
 d2e1a72fcca58-861669c6df9mr7906397b3a.7.1788514918708; Fri, 04 Sep 2026
 02:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
In-Reply-To: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:47 +0200
X-Gm-Features: AcwNN1WY3Q65S3OXvIJFG9cyzWdBxYBgoNhzeyg3bRWcOCH2qLTUuWKCE0IcBIQ
Message-ID: <CAPx+jO8UoYuWmKRi7ZNb=5mhnoeZB0iLHeqRqC3d+_NO1mx3zg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci_am654: Fix DDR50 mode for cards without
 tuning support
To: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pascal EBERHARD <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfXwJ8UpELDoF0n
 7Cnz+BM4MFkashQUqrNi28f8sGlLXzz0DgS248UxeapZ00kqyYwHkv1LuRmOUYHLOYjF5nVtEqZ
 bcqPQ+XHoTWSAaJtD02TVN4lXjrn609H+AD6Ybf2ncwahn86A8vXnHKZU2ZkyBPNrLW8faAF8md
 8QZXHHWGuo072zNvn5IALXdBdEG15nef3NndP98nwDPfLEAp+/Kygv1+aHQ9FzbbRFVG3lltxhi
 DTaoD/cjwnHF1epgUsrQgFQv+PCVDsvYz7QisdId38Wgo7T1BhVHwl/px9ZcH4kukkDMNcAHO2C
 r83Gk4HxyM6r9lD7Ofjve7EN2FpZLdm1hwcAYxQqR2siE6wfDj01F2Vb6VZCXiSZxr/PD0fHk3X
 aYx1zxUc2T+caxgbut56NFax+6OCMFsLuveVheDW6/gccUuluB17QQol0uHVWbaPxouEeN/JdQW
 WRdPeIlkVo4Pum4gi3Q==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=6a9a9267 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8 a=P-IC7800AAAA:8
 a=Yx-hDG8L3HprUginNkQA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: leywLhXE1uctKv01f6g_0hYJkzrJElmd
X-Proofpoint-GUID: leywLhXE1uctKv01f6g_0hYJkzrJElmd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfXyFUjM6uMBhQQ
 hpiT/E8EXfSkspuZkc2yS0zZ+bLZVw/vzhoyj1eCVlX3Pm5y+t4s//HYeuHWoc/SoefsRBjGN9b
 zNNmP0NYtL/07+xwkZ5TNoVAQgnvAfI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040088

On Fri, Aug 7, 2026 at 1:08=E2=80=AFPM Diogo Ivo (Schneider Electric)
<diogo.ivo@bootlin.com> wrote:
>
> DDR50 mode is not required to support the tuning command CMD19 by the
> eMMC/SD specification, meaning that calibration may fail on cards that
> do not implement it. This series fixes four issues discovered when
> using such cards:
>
>   - Patch 1 moves the tuning_loop counter from a persistent struct field
>     to a local variable, preventing failed tuning attempts from depleting
>     the retry budget across calls.
>
>   - Patch 2 ensures the command/data line reset is always performed
>     after tuning, even on failure, preventing stale data in the
>     controller buffer.
>
>   - Patch 3 clears the ITAPDLY enable and delay values on tuning
>     failure so that leftover calibration values do not interfere with
>     subsequent I/O.
>
>   - Patch 4 falls back to the DT-provided itap delay value for DDR50
>     when tuning fails in this mode, making a best-effort attempt at a
>     known-good delay being programmed.
>
> Together these changes make DDR50 functional on TI J721E SoCs with
> cards that lack CMD19 tuning support. This second version addresses
> all comments from Sashiko, which I found to be correct.
>
> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
> ---
> Changes in v3:
> - Collect R-b from Judith and A-b from Adrian
> - Add debug print when applying DT fallback values (Patch 4)
> - Link to v2: https://patch.msgid.link/20260803-am654-sdhci-v2-0-a5ee5be8=
6133@bootlin.com
>

The series applied for fixes, thanks!

Note that, I added a fixes/stable tag to patch1 as well since the
other patches depend on it.

Kind regards
Uffe
