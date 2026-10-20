Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502940;
	b=AEamvC2nphY2Anp7mEh92PnmFM5zGGF+tT3uujFRsIBAkpHNK+2Ux7cY5DNRSixW+kW/
	 lgzuQC9+EMKpMvb58rp4Sbn+duIAkw/kOqE7kwq8KISHaKm+TxysgOd+XJsx9QsDAuZP6
	 FtcIGh9tahomfEJJVdzz/RCH/nuOWIfS6nDu8W3rECt4JrtAPsT9PPL37SXSC3M107Bra
	 kZuAlA6+wdp5Nhu0IgmTsaBzrzsv7sFBO0tS3zTNnX+jYYmi3DRLBPKopDKzWk5DFTwF8
	 89dQENKvEyOehiGaQ32kgIRd7BYUYSQndBpndLmP7Oj6GbY6krGy+/JVfdkyZuucyYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502940;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=g6zxXx5rgVEHyEDIN1thSxX0UYekg66jtrYrLF3czZc=;
	b=HxckVLVRjHeyDX67DdZ2tlKx5TiF144gVrOD+LXqWiWkP/Nw4xz/r2uEJy1uyCDX4Fqe
	 F3yxliEAhxFf0rkhSAZUAyYBBhC+FnB9EEtQLuMMlk/Mgf8ZYmCTX4E6zjF99nRWVb8f5
	 n3T5EzG1xDW52auYl/2HVi47IxVnYxE5t2b6ItIRJ15++bUpZx6qhftSGlRTfbS7xcnYC
	 PPaw4ynooaaOB+4OtDizgBfgVHIMXzY9/6rGsEqE/bOGQwMjtajPVxdspleaEISbdPWQG
	 YK6ZyNG26PpFa7GUvQnU0asPEUss+4sA4ar+KKmHIHwIkxqlw7l1RZm/7js3kiVns5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KUpuNFga;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UEWOHXbN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558E606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D558E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KUpuNFga;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UEWOHXbN
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDAKxY2214653
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g6zxXx5rgVEHyEDIN1thSxX0UYekg66jtrYrLF3czZc=; b=KUpuNFgaVxdtDKc2
	I2dDzcn1Akrb0hWrkgddAbPFLSkltiP5lrk+uBuO6fG/lAzTVoUkFT1I0otQdp9H
	9aURM+kUpmaVOE5C6SBlFPHSXdR7F8upQaQ2uUTBVzSobv+Su+KtZ0ebaxabF5iO
	SqDcuukONJ+CHJ1/LUe4FMW6cbyHvwi0g+0O8GIqWC9CfoN+nYlDMz2/N56VJ1Ab
	5NTupjeT0cnAQJ1F1QDQNUq8GPsXHq63VuZkhybH6a7HHBXna/WhV2yxxQyKoo7+
	6PqV9ZnwOECwNCWBbQLEblQUMrKUvO5APUsdx+7oGJu3UhzBUXKR6xthn0sF9m84
	qcra1g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5ntk0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:28:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ae8e7e546so687252785a.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502938; x=1793107738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g6zxXx5rgVEHyEDIN1thSxX0UYekg66jtrYrLF3czZc=;
        b=UEWOHXbN3SXM/kokrB6PpgPlv7/Q8DhA7clRfA1aZ9poNgoeX5XP3BOWdq7se6q4Wv
         JHa5kIVF/snpnbK/RlT0OFw71WM3O5Alfh5jWns6x/Ea1xzoa1ky/hlLZ1Ee4++mhbd5
         dRW6aw6ujTRoyMJhzCN7RfdSKn69bIVYPOA3+Y5buVhpVDrAtZ8lyui7Y3BIsgh4a1Fe
         BGtXUT9Xl7Q5tXkpZrZOonWtc/XylSjRaQR97KuwCVN1fcMw8ZDO0OkZzFMmBx2XpMaI
         HB5OiSo4hUzu1wKIWPnJEXJiBVwHpia13UWscg+La2ntTytNpEjZ1mg6eJKW4vyciJwB
         Qdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502938; x=1793107738;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g6zxXx5rgVEHyEDIN1thSxX0UYekg66jtrYrLF3czZc=;
        b=nx9csUS8SZwlyog5aBh+32Wmh16dpaAqLGjeEnyjEodvspHFjHy3NJacAWCX0NA7uX
         ngxZYOo4OhlKd3uRKSTsRqvdUEW3TyBbgwUYFqMEKklsilvD8q4ukm+mJty9TzRD5qCC
         Bups3sFflfuuVro2PUucLzP3t2PIdyOdHwc8bHwu2yE+7ote5O5OXBsVQdrISPr0dM6D
         /OZAkJcNjRzGzU2+icLAqii3gZeCGpqTA/aIzoZrdnsAhBSNKJA1qKStN6EK0y5Tk5Rj
         CuZcB6q9yNT5UvSN4gNPRZI7EtyQuDnN6W/QZ69QUcqFLxNr7OdY0Mv56iS7GEWAEWgs
         lSkg==
X-Forwarded-Encrypted: i=1; AKwUvBxZqWXyGEPPCTQbNII2azmq1JrBqrjDk7Ivji6RhOxtKB1S5QMAV43sqm+lKoCEd2fgl8CoPiU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmaLiSmF2LV4Tjfb/hg+i/KDZiDKMjeF4BUdnmjkfC6ImFAbj1
	90aMCtfpEyJyUlN8Om9SvqRqaCWugtWob22sRlnrScVGY74CScrOq1XZ1MJu5rzhEY+B4y/Tr9l
	CFid9zBZX5erNAtSdN+5Yn19nMam0tDSc1mKVZ5Oj0Dv/RmWCFAdI9tNMgeU=
X-Gm-Gg: AYBFou39j1WgaOmWKGEpegix1xsDfkviTaUrEi07ajvcBdhwnAW/FsIUTvR7K2HBgwN
	06GV6A1ErhWUDnjOHz19iulo6/bAfVtWv5GizpgRj+BZq4v06ZOUFyUZqlmWXOq/xYf5SrYchIn
	7mBWfyPVA7VWJuYG7xjU2PNEsFOt3zods/zayoZEs8VNcjLBwcMiHtaMprspKinVMQNkoM6/n8N
	bTmjmZCxC/B/oFsPI0CECj/jcPbLshYH7yXZIeerJuAsqg2KHoNDM6+oQya1FUi9YTtMBHW2VDu
	232+Na1Qjlg1iPgZcqu3zXiYRfxSD80d+Dm3qK8o5Dl6/FFX3kKttfYA2aTMpywigRhHBov69UP
	BKmbRSw/Sfz0p1XXf7JGt8Lfz+qw=
X-Received: by 2002:a05:620a:40d3:b0:93f:4f87:4f5e with SMTP id af79cd13be357-93f4f8751a0mr191652385a.72.1792502938206;
        Tue, 20 Oct 2026 06:28:58 -0700 (PDT)
X-Received: by 2002:a05:620a:40d3:b0:93f:4f87:4f5e with SMTP id af79cd13be357-93f4f8751a0mr191649785a.72.1792502937823;
        Tue, 20 Oct 2026 06:28:57 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fab0b9dcsm4429835e9.2.2026.10.20.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:28:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Handle direction register read errors in IRQ paths
Date: Tue, 20 Oct 2026 15:28:52 +0200
Message-ID: <179250292927.34033.5879344425589033751.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018165003.3372368-1-sahaj123.sc@gmail.com>
References: <20261018165003.3372368-1-sahaj123.sc@gmail.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfX94tR9jPUjftW
 SHsHl6Wmp2SHkZ5283ykQHDinhqwoH0OqqkQO1tyT6M3WqGZ5nahPWTsBl1v4Gp8dwPdzJ5tP8r
 RPsienBT8+lSvQ9/RyQQGUmRYoAALE4=
X-Proofpoint-GUID: rBruFqF2LsBrsfm37HTGv83IOtVJ-5UL
X-Proofpoint-ORIG-GUID: rBruFqF2LsBrsfm37HTGv83IOtVJ-5UL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfX0rWeutf3LSDg
 yf+UA9uuiihJL5RcdqWxSxQ4PQt1sXXfTWp7Dz+GJs6Vcefu9FNF2Ys6G5U8ph+vxi75SwVXGJT
 ionfP8HCUxLrpwhSuKq8ETOT2WqALFWhQrrvqvkhDVWH9AXoeQqeLUsu1vzl36reW1mIH/6fd7e
 uu/4j6XJszXbM5QpvKeFI4s1uzG1v7LjuDEnxOdmpz+9AT9MFehjFcegovTD0fm1TiT8uXlT9hc
 rHHy5gfKFlXdVEep610C1Y/VXnVwJkDzotNqt60gQ/1ZGYmavpERtTRxPjKHLAQROJZieHoxRGj
 muvoebYOcxv3M/SI3W8SWQXTiINcQjbRshnm2qBZVLL4f53I5Gh9pe0n7b73UPRg3AQRY0xqs7/
 Su8x/fhLMZv542MqVM5zCgOUFk1uOfvYbUQ+ZqEM4yM5Sp+RcQytpuFjH0Cne5nl/++KnaqHYnt
 KQBhxdl27QpB3qo0yCg==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad76c9a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Y_VTxXPCLCIGpK0l0V0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200053


On Sun, 18 Oct 2026 22:20:03 +0530, Sahaj Chaudhari wrote:
> Three IRQ paths ignore the result of reading the direction registers
> and then use the destination bitmap. pca953x_read_regs() does not populate
> that bitmap when regmap_bulk_read() fails, leaving the callers to use
> uninitialized stack data.
> 
> This can select incorrect GPIOs for direction changes during IRQ bus
> synchronization, corrupt the saved input state during IRQ setup, or
> produce incorrect pending interrupt decisions.
> 
> [...]

Applied, thanks!

[1/1] gpio: pca953x: Handle direction register read errors in IRQ paths
      https://git.kernel.org/brgl/c/a0fe269293509acdd93b9cfb3f46636f7b91b33a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
