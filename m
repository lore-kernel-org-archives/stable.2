Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214643;
	b=gI3wBaUS/0NiVBgdJjRvkKWGKU5KCJ/nUmPXI39us3I0JidYTqUFveVjz0j9yaNfK3Vy
	 0+tV6hfB01FwpAyjVkSpPa4J7fY+LOSj/nkwJqBuc21nxy7lGq4t2gI67pxYY5OMsmKNO
	 /QfkvNrfSiimFzR1WMtJ6GWzNRu99klY0WDzx3DX1fUYzi//8YI05R1lgnEH8tkV0iq/T
	 IpE815g8LwUFN5XgV4WAx+zertIfVouXPo0Ns6Wembq3L7ZDZ8UuxU70zYWJmI/C2Yalw
	 1tYYM2AySS91nMyS3rQ26rWqgr3Ebj1qPKMK2IqpOx4Yzfjs8ksZa8GAKakCuLmnpwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214643;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XzEGE3tZdC7w1G3PUODyH7sAeFFJNDrzFSsizGE/Oiw=;
	b=3dllhUwjDh6pqxA6DqrikZO8CnI9xODTnKCzAC7SX/GCUo/OSRsbDzKLCICTcpyOJFbs
	 C7ol/+ueTpy0zK4kN0ZAKgRVOz+kyJVyAabSCPAt66t+ssu0bUhXDF+5dIkmvsjD51nRm
	 uqtiP/LzAAC+cQKxTPDZDvhKfKDTXAlMefS4/QuStSBfSyYefTRRX9Z4UCyNqKiyOXe7T
	 HjuA/zc4u5Unejh11puwm3dpSXRc0q3hZZc6cf0DE/adGzFA9xO4LAmsPOild7jBusUiO
	 OzrB/XgOeqQemDRQct0jjE6ST0ssDB5905hpXFsUHkkAtIJxxPd3GeQFPdW8PjZRp+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qi51nJHP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VeFy6aM3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F64606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2F64606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qi51nJHP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VeFy6aM3
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A969vRT2668040
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 08:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XzEGE3tZdC7w1G3PUODyH7sAeFFJNDrzFSsizGE/Oiw=; b=Qi51nJHPDFbJ7q8n
	qXkhTkmLCX/0LKCsplGWLTa1YMVJ3RwOt9AsTDmtZxJF62wlaCj3zv2Ze8Est1aa
	580pukGyxUUlTtAc8xrMQzhh/GOoI2A4URoEJL+LMW9hkiSg3154okCev2fGp00b
	vXkH87SlXdmdYv38+2XRSmP6FVSWZjBLfFRovyeJSZT9qb3mMyipvzS/O9hClenr
	2dHkQm6Elrvpwp71fNarlQIDxOvNn+ieCYjrAQGylXPpanmlz+Bn5OKKknMDbuDv
	/NQ2viBqKaC33FiMSFCOuqqWOvb2Q/aBWksxnXWh2w4lUQcv4jFEtrTqXdpsV8rM
	rWsEJA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw99nane-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:57:22 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99b92772710so572247241.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 00:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794214641; x=1794819441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XzEGE3tZdC7w1G3PUODyH7sAeFFJNDrzFSsizGE/Oiw=;
        b=VeFy6aM3M2DUbgHAo/GOqbpk9ncqOFx5dD+e1aYRK0Q2Fxoti7uLbz7kV/6Ka2XWMx
         Ws37jKObk+ZQd+ZkKNzLS+VZMNckFJu9O+1hWC/yxJ1O72A4639vF7ZwI8O2zx4T0/vR
         7nRVlvBOP11Uh4M3/IBsBOmxdpg9aE9Ye2FC2t98fGbWwS5DrrUfKmJGRvzdVXd8YHMn
         HKuRYDH3OsrcccEoEayJ90TS/xZauzdfb17nL90es/bVRAzHMyEDHJ7LGu1Ya7Xkdtrl
         lQZ3Cf+o7cq3CDmDIArPLdFtgtstcJYcSUeDER3T4bA9xtTfxj6IIOaa4zXJWNG5xUkr
         d2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214641; x=1794819441;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzEGE3tZdC7w1G3PUODyH7sAeFFJNDrzFSsizGE/Oiw=;
        b=FEfrpSrfPP+fwl7JPbz8r8zbtQHglLPV8uSY8Cx/2TskuGKYlrDW65UxDdI1jOjUwH
         TNZLxwx9xc5nX9oel1GAhL//HJjjGz56cMoJjE2WMeHwVqoQWlCgJj2BTGaU8/IpAfSG
         QQVsi3N2+HfiRcLsHOvNOWiSKjXaYIqc0polmZdiZZhzy+4xuyBMRI69GZW7CN7ecN+D
         Hg+sQYzdg0HQCLbnovlVwJIfxoqH0VypcEBP8I5yyc0j6kAUYT20hsTdVa6BQtizJ3BG
         1vGb58qNg7KCS1cjhVuTH1JeyfbtRmo9Si3U0cIwLC+oTNCL3RDF9awVEQz03wpAJtmE
         5c3g==
X-Forwarded-Encrypted: i=1; AL+hErF1YO9+UjIAJ+preprw18vU1uNGyLrM6+UrTK70T3D/+tN8MxCvBBnOYeUWBfFIGNuLkTOyNlM=@vger.kernel.org
X-Gm-Message-State: APuU4Z++LmdDAutNP0IOrNsxq9rnzWpyVDa6ULyGYH00nNF/ApvrcmnU
	AxUTn2g8FOy0LJyTWvDqm51vkH22503X11Qgcm3xbWSIznLY301fjmCjCcB/m9jGSgae22jMfw0
	hMjvYDJ7P9Mtd8qN87b4Ab+nteSohJsdq04j83/fsAg0KYCaiYXwfbGdZ4vA=
X-Gm-Gg: AYBFou2q20peBEve7d5+vyxsadR0018zzm3QnDT9ZqrnQjVbbE96UglEzoCF+NDbXa3
	0MvttwZmD2DXeQ3sEhfZLq8OgAqkVv6EB8T6jBaFNsAie8l6t0mVtVnJNe2fK799rkGGoQWEeWT
	3s2I1HhnCoizPS0kb1ZveRByiYVpVa5XMNI6mRbze+knGu8dafLoIn/j6goAGC0F5jNsdx9M/1+
	GEJLGM7TpZqGuk9kG3Ug2vcYGTnGaRxFlnXhrpv+GZ89WdDqbOHQjbDVRBIq5jmrONjUF1XCTs0
	rNMq8w0ciWMx7Ue9YOtruazZGIBKpz1xWrUXpD+J1QpGTvidT4PcwcdCHZo1ZDG8NHgiK81egnE
	/uah4Z+5Nn99pL9ChX9SkXZXGhn2m0hnUPM0o5mh+R9EmDxN0eNjSh+BZZtNOihyCXkV6Dp9hiZ
	cp/o/4tuEf/XIu7592Uaxes1gnmVa0kPOXdvHo+AX7vn1dsFaouPC1Wc0RoUl7Gw==
X-Received: by 2002:a05:6102:3ed4:b0:7cc:1045:604 with SMTP id ada2fe7eead31-7d2db195765mr1024636137.30.1794214641149;
        Mon, 09 Nov 2026 00:57:21 -0800 (PST)
X-Received: by 2002:a05:6102:3ed4:b0:7cc:1045:604 with SMTP id ada2fe7eead31-7d2db195765mr1024622137.30.1794214640680;
        Mon, 09 Nov 2026 00:57:20 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f38e55sm9001442f8f.4.2026.11.09.00.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:57:19 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio: of: fix potential misconfiguration of hogged lines
Date: Mon,  9 Nov 2026 09:57:18 +0100
Message-ID: <179421463614.21176.6551038527438941872.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-gpiolib-of-hog-uninitialized-v1-1-fcaeaccefab6@oss.qualcomm.com>
References: <20261105-gpiolib-of-hog-uninitialized-v1-1-fcaeaccefab6@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: oeKS3g3WLE2fOB9ewI3AAOALoy5QSowF
X-Proofpoint-GUID: oeKS3g3WLE2fOB9ewI3AAOALoy5QSowF
X-Authority-Analysis: v=2.4 cv=CMq/zhrD c=1 sm=1 tr=0 ts=6af18af2 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ePiHbNq-gTG-vOfASXAA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX3pK4HeHP4CNq
 yeJ2k6I+V+DFQB5ybXQaS2LBjURskvjIbpF6t9okmH8jrBQYVnxWk2t+x1Qt7ZtT6tHpA25ssBD
 yJ1lTi8mYywobNKCj//SRHaYgoNmXNV5BariB1G8aSKDkDEbU1f9GQI2yTtMfeWFNuwHkf3kR+l
 xP9ELXuTKzgsizRThXaJD7ZaEdSRTuNztCoTUCblptGHZrAzoH7y8SFr4q28kzKExiQrGzL9Dfa
 oEqT9giRcTPqGnpsqC3Xj9b/uPQq8g6/C0G7BuAWQ/Zf1EYlkW47/lT3uVcre8Wy9chD1dGYmiG
 DlWgkx6kOHR997iDpTlNOWsJJCXHmoTvJRgHXgLZUOmvKjkTy/fXW2NNwvEBbqAbQ903DANg/C/
 2Wz2g2NKuw/kl+oRdHuuZhs9LGHMI6FV/Yv3XHS7sUd8UqtNK9U2vm1rkPC3drCZWWvJo3fPNq1
 CoZ9jN53BVGekptAeJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX4TJOGKZivyuF
 IewZZ1VZN3thT0uEj1SmrSi65zZPLfVAB5moGOweTIXmhRj3/hHLyqHytJATCyEMH/pgtBY4M+3
 /Q20xglxYwc4azuo5T4RTg5waYNZN6Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090035


On Thu, 05 Nov 2026 14:37:52 +0100, Bartosz Golaszewski wrote:
> In of_gpiochip_get_lflags() the local variable xlate_flags is declared
> without being initialized before its address is passed to
> of_xlate_and_get_gpiod_flags() when processing a devicetree gpio-hog
> child node. If a driver uses an of_xlate() callback that doesn't update
> the flags argument (like gpiochip_fwd_delay_of_xlate()) we'll end up
> passing that uninitialized value to of_convert_gpio_flags(), potentially
> misconfiguring the hogged GPIO.
> 
> [...]

Applied, thanks!

[1/1] gpio: of: fix potential misconfiguration of hogged lines
      https://git.kernel.org/brgl/c/c62364eeac0f123478fca2f2d8e2424fdcd55032

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
