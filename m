Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702375;
	b=MXslgmnk4IBrL5bfGmnj45VbzrMUdLkGLzEJPucMa1trbtUVw1hodGb82Qlxx4yJspz7
	 VBcbZf38hDM23zLRzVne68lIrTQsWatJUJa8HyL6SMvEnsMyeEdq9LT3fgPXrBb1R7voU
	 6DdAdM29D5xFkZ5NIZCpVyHmnUexbQDYHGesewLXee0sLpjzWnteXOcgzEjEGUCGKXZMt
	 zExe9dk2q1lUwQPGjpssz3nQ3bizt1q0PS0ciq2N7DtIENV9yf3+UJ7WQkrt3385/CrEm
	 gpylrV3hdU1Fn7yl8oqmHxqbJUmEOtVKStEsabxsCv88mnnm70+qCuUfLJJjIEuczrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702375;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jzHa1CmHKmJMRHjY9FnOJa7GMC+xZGSlda3chEFbwPQ=;
	b=z54fPIyp11j1jbL+566g0j7wEw0NM2sTH+0R9VJoWBCsSLRqOvkY39WlxeSezdj+J6o1
	 Ofx2pJlqzu6ti9z+BCrwdGgulW59QMkG8Cbt9VN/KAG9WrtIBIMJT2QRgcn/302fWw68S
	 IaKDtgOcemIwyx2ci6gYddCjKGOs9/10rrKa/7rfzzqZs2YOCUvOpefI/l822I9eglrTL
	 eQvTwfyhnaCkwM+w0mtdyiF/k74kdKkTZSk/VCyrroP906IBAXanLIRnN5PiTlSeQQ6sM
	 ldBqkhFPrQeIr8znY6Wy3wNbpUBPPhRwC+DqTGod2EHbjYXc3vK192PZrsf09MtgmFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dxeFm0Er;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2PlYaYx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9085606A331
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9085606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dxeFm0Er;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2PlYaYx
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVU4e2911803
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jzHa1CmHKmJMRHjY9FnOJa7GMC+xZGSlda3chEFbwPQ=; b=dxeFm0ErDnrSCXQH
	JEeMxJgtReKsXrMGuyOL5DBDrz/mL8fguzJDnjrmpE3kSkLbTFEqKzeD78jTpytD
	Th+Y+dcuabq6GMi4UxcxDVeNOGjz+unvcgn1M5xmFuu4XpXFJZk79NuLQci+N6dz
	Sb/P6SDhy391emGZNemSNr1KWzkr4Ly6tJ0vKvFvq5/clnXRM0W92EnFx4UcqM+T
	IgEFhpmwW0LpvnGSbHlxSkP63n6Px9zkkARw2lh/goyT3eUKk53EOth9cGnu6zFf
	CdTZxJPI4kQADmlN6sxbzYS0NaGx/yhOroOde6rhBaSWIXbQQWHd2lW/d+wo7tmZ
	oE3Fdw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak02k4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:12:53 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eab0467c89so7402918e0c.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795702373; x=1796307173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jzHa1CmHKmJMRHjY9FnOJa7GMC+xZGSlda3chEFbwPQ=;
        b=I2PlYaYxd31+FbfnRdzSH3txjo3SOWkr8TMBYxgMl3zctE/8lfj3IMgwVz899Xqbey
         auA0SlAVbbG1QPfXvS6Dm3d8LBVCuUv5S9VEBZxOVVlJfrbW5Qh0iX6o2vzdx/4D4m2s
         mHe5Up9xSm6zYuQGdYC+f6y8q1DE8pCtsbiD/dzwu2ImOrgd1aTSF2TfQC6D1Omr8mBX
         AU5CSDppnwApCcnNblXCP9txKQKiJ04AAJnzI9s+1XMgIaqtYmv0uAeMdXClZH0aTGAn
         Js3BMQL9K76qIzoqBt89rHtwJBtksmRbPCSHfHERi7qIw5d0ajRGCnGtRNygB7pfF1Tv
         FYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702373; x=1796307173;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzHa1CmHKmJMRHjY9FnOJa7GMC+xZGSlda3chEFbwPQ=;
        b=UMelWNl9XpjrWGxKcoKiydQt4noPggVeFUIvWp2Z1CzPvHFifeiQQPOIgvZN80N6Bq
         uVWbDDp0fvZ2hqUqE3BEu70QMUybStwgsyXL0fsEeRj6bhgVn2pE0StttK/1p9cLtJHx
         7B++6XBMisVDdo+nA6cAWYc06jQDRUvm2Lk/N+jZBgKP3x3me15oCqD/qCzucZP51k5P
         ZVDYUqHEwFKOjeAHBxLsjsgj0qx2Rs+gMvZ4tcXhg41DuQy0i3NqIiXMeAYePBwnAoGy
         Q1e0pQHnYiA7BP0i0KP3xeBpUWL+VIw0xzTPnUUyEofhG2FNJYicSHeUjz3Zsqb/Tiss
         Aifw==
X-Forwarded-Encrypted: i=1; AL+hErHZFGkBYIgSZLuVfoZ9rxTz9QMHdfwKDeVfaDY5rfrIZX+4wi59DkxGFxZv1BffTS2a8s4+6q0=@vger.kernel.org
X-Gm-Message-State: APuU4Z924QqyIiFJ9m1piv6BXWzInyzVT7d7xvHuiN6BpRM7KZqhH1LJ
	Vo3M2Gs/QJJY5VqQviUl78evjMFWwgg219QuzhMfhwiMCg29nFHBfYWZsux8XERvivU+WrJrieF
	ECKNIvjeZ5GjcqnvCTejTF7Jz8FnAzAte6MedCBYpemY1MSbT09pSACDfpHo=
X-Gm-Gg: AZFdTZdaItgOG+Z1zjLj3YmFGaxv9nNR6xGRbxlaS1RxFYv1T2xO3Xu1tuL8UpBOXAM
	f1GPjCPtTP0sBFLePt7qn4dBUEqorAsRkVxWjesNhsQ5KC0x0ryCke6pwyDtL24sAYfXn/tcTRe
	6epytqP6a+WhTRlsYjt/Ba5oejAteQy+IAVdMZzI7nCvbGgb6yE9Fj4vIhqIZy1kHre/U9WsGyO
	e9MhrCKX/z+PuZfoxhNHQtVY1immS8IQADg/O640XTogeJGFi98jEBIYm813DxS6+YVsXBVLqLl
	2beT3ountemOLDJqTYuJIwtIR5oIQqJxpjO6/mLJdVkSmz9v4WKJrj6duemkjbwQvLYYtML5O6e
	A3JxCZ/N0Yp8wKbFvR4anJwtvY7QjqshJMRgWEGjMOa2l4/BjxSE8oiYSbYeh4G7SX6k5FmEATw
	MqENL3I7lqVm54ekr3dDDBiUjjfdBE8tPg4pE46NboSzH0De5J1+DoEN7AFVpLkw==
X-Received: by 2002:a05:6122:4fa0:b0:5ee:48a1:7a4b with SMTP id 71dfb90a1353d-5ee8afe028cmr12428976e0c.23.1795702372795;
        Thu, 26 Nov 2026 06:12:52 -0800 (PST)
X-Received: by 2002:a05:6122:4fa0:b0:5ee:48a1:7a4b with SMTP id 71dfb90a1353d-5ee8afe028cmr12428947e0c.23.1795702372435;
        Thu, 26 Nov 2026 06:12:52 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9065744esm321417255e9.1.2026.11.26.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:12:51 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, stable@vger.kernel.org,
        Norman Herms <dockseed@proton.me>
Subject: Re: [PATCH] gpiolib: use the of_xlate() result when hogging lines
Date: Thu, 26 Nov 2026 15:12:50 +0100
Message-ID: <179570236790.22568.16206006799551042722.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125-gpio-three-cell-hog-v1-1-724b15c4f0d8@oss.qualcomm.com>
References: <20261125-gpio-three-cell-hog-v1-1-724b15c4f0d8@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b083e65 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=z3hFKQ6RnDTCmMfHHxkA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: _RcBXJ9Qbu26qzlnwQGekmNUWYhCmE35
X-Proofpoint-GUID: _RcBXJ9Qbu26qzlnwQGekmNUWYhCmE35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NSBTYWx0ZWRfX3xPQ4Bdwwzlg
 u/cRwSQ85vS9XxwFpPxWm2gPGf7nU5ctpLx3dW4WTqNoJjJFk3wwyoqJm99IitF8AdkznsD1LHE
 1HnTNfukC8C/Zb+12BpBEExl7gHBfOxe8MJTyum5sAkx6XViGoFGIbZG2TLvwS+6ijK3xzhgq3K
 X3QduEtaSye/oNOUJiyP9Vc9eIqHJvMePPYg3poQiKJuBbGZlPIIdbx149LuZc6yit9ClXhFWIA
 /04pWagIM/OYkwOdtoyNylAr4yOg69+kZtrOuDf/sJ9laJMHOub26YC/14PmCBauh0yUDovHLra
 1c29WsyWynslOXUXGUeWRC1uQ4i137cHL3NlnA6BT7P94KRj6W6iQAF56GrQxprQSVMfqVHE42W
 x2RwyypVOL85NRCOrVCcYFLd7PaRYZn844uHq/ioNLTiQd7yr4gDHwSrsm3vmfYtAU34ObQAvhH
 Y31LQW95Gwy4foGzuXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NSBTYWx0ZWRfXyXeytG7HphdN
 AyyOvUN8MZ8kiICjmOES2OLeerTtVuuV09gUiuNGg1MtucnRAxCs5YaLCVNFOFrbWwFjXr7lIPW
 ENG+8o8zWS+hTOLi2dcEcM4J78YPGvE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260055


On Wed, 25 Nov 2026 16:03:41 +0100, Bartosz Golaszewski wrote:
> Since commit d1d564ec4992 ("gpio: move hogs into GPIO core"),
> gpiochip_add_hog() takes the hogged line from the first cell of the
> "gpios" property. The of_xlate() callback is still called for OF nodes
> but only to get the flags so on controllers that compute the offset in
> of_xlate() (sunxi, Qualcomm PMIC GPIOs, tegra186, ...) the wrong line is
> hogged.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: use the of_xlate() result when hogging lines
      https://git.kernel.org/brgl/c/64b7a47c24cd1fa01fd7e70bdfd72ea95c8c8e60

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
