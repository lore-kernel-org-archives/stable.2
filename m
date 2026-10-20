Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502406;
	b=xbeQzElRWCpxqPbUbtWr/SshZm4SfmEI8GbmcWQ3a+4SHoDfBFJs3h2rI/JkCS9XV+68
	 1aQIN/ZqFSZV8oyvMnN1ss5SPkLi+sRCsee4AO/5S9xLzFGKhVkZgVE0dOh0jY6LbmJ5m
	 NUZJOAMrtcGt7J0wtldLDURg5wfMaIhKORhUJvDRwv7pMql+csl8FoJE3Ig3H2wSztYfC
	 QbgjINCRP2w3PFwcIFrPPoflrDVxG9UDMGwYkyKWPAh/BIdKJ1nJGoEu1h8EowhUp8CYb
	 w7zQS+A6SF55VXwPdKBDxstarKtxzaiMjQ64SV+8iUpwDu2J/WY4cR9+5vXRujMVotQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502406;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Jsz5go7Fr+PyZnjWF9NG/8p6Hqrw5fnSeFiniwyLeRU=;
	b=ZnoDLeHx0GocdWu/zs2BsFbznr59XV+xRjm1aoVvTBfV4ItZqMf+sV9bA4cjjp1MFBAX
	 hXxRxvbWq+S4ka0QZZugqPJQy/rWdpQ18jlzH7jjPLQGDwNM4PuRXdgDccN71VYjLEeoL
	 mz5s0oAvEm67cn/aqpXX1zarGkItNR5gV3sGhe3jYN4u4NaPwpno454cPYzGTYrnret5m
	 jV2BoQ9x+1qqGJindT/FOH5hUDBXY1eUmvzKbknI4azloRq9bba5aT/a7phxUhXL8VuWB
	 tOsJgvw8CdEJowngMPJaYziYOSGmjYVGNO2Tp9uhhuXROwcskMpUugtEWsRZ6NxaCHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZGNJw0iz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N9Q4qmp1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D3606A31E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B08D3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZGNJw0iz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N9Q4qmp1
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDA2MK2809720
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jsz5go7Fr+PyZnjWF9NG/8p6Hqrw5fnSeFiniwyLeRU=; b=ZGNJw0izoFLblHbk
	3ncKK2m28JNhtqOUNNLHlFox74uuE3hb64ioUhQyU1iLQFHSIywNg8j2PhHsWbwG
	SEC+vKLM7uUaAfyI+kmEbTcP3PC59TavdZHL1fphM64Tp1xWJhn7otCFxukmTQUb
	kdbnTBqCIXGauCbMLR7lEJ8ExaVyMUselAuO+iN+2EO0CuRRiPjT6+2q+hFk0AS0
	x2RuGCv3eETs+jCOPCss6daWyT1xzL7Z0vmOwsfoVFXYGuG9sCxEzOymRwOL0A8B
	vYTFMA8/Ch49ACeheFHR2/qsmoylHAnBzJYrG1x0fhkmjoW7xStGf88blpU2B3Pm
	DHHs/g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p2n4b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:20:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53639e47be2so65069321cf.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502403; x=1793107203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jsz5go7Fr+PyZnjWF9NG/8p6Hqrw5fnSeFiniwyLeRU=;
        b=N9Q4qmp19ANKDDX/cLc9WwFLkSGKO3nen+uLP8f7z/Zg9AvDmwtY36S2nWKRwac7UJ
         ec9wvjKwYWXxyUXybszURXwpEfqBiKqMoGot1tX9VR6z0AMXipjLGDTMVcQ5JBcaA+1I
         wdCeNxcpxFAr2pzd5xbNGa/0lePunoerVzMRUjm+OkvzKTlazSuzkewuwdW9gOkB2qNk
         //ElSKeuT6XIfVHp6hzBNP5QY579nH/YW+fPzLStfFAbZJ/aVXwMfkE0CQjzN8ayGEfQ
         Ei2LcJAtrEPlMJkicJ0shEraOdLGnFoYX9qX0TmLrJsciijRAPPwrFdDrbZSyfx9kVIR
         3D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502403; x=1793107203;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jsz5go7Fr+PyZnjWF9NG/8p6Hqrw5fnSeFiniwyLeRU=;
        b=Ju3jgzESBrEP4SmKn26LPJpD+8vye4AMzTol+HvsmL+aXF7O50pnD9j8bcN8vKYb1C
         Jc3kITdr7d/WMHvvrhNs1dpFu/qQNQbUs48aiE9FwUR+9BmWfmJ+X9/o81ysy2+FcvbL
         /FnAaadiChopEro6MlPuiSNyPCbo93vhyVTiJsdDjOg8npPX0i/xxnwQh5eU/kRjH6ZS
         u6wo8ypsPiggbP5/aBVpfnVy3NaDVRpj9eTVvwokB75NKJ6XiHnKudzrVl14QcQ1eYNG
         Jj/FG/1T4jSbEwypXITsVz1R814L4JKtxH6Mk3HbkMnnSpKkP7KPdsHKpWLrzk8tbA9Q
         mpUw==
X-Forwarded-Encrypted: i=1; AKwUvBwx0nrJEwOayD+Notd0DD5Q5wO1wJ2txUK/PHialrk7ouy//unpEAHwFeD9vr5zVojRPYpjGSE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKa9TJCXzdg9IYsVreqYWihpHHPv5h7CI5Rb9bA+0LXSkEAHWoN
	M2vsuPUqmoAuxzMUvJcf4xAxrOPWUJZ6EWJkC4dsiHdoL1/rDFqUyjrkvrDjaLdV+6Fjw30nIpS
	YkkcqA773Ift15GeS+5gG4Xx9mXZK4lMCmhaRgN6bTZhEOWkCA2PaTlcDgq8=
X-Gm-Gg: AYBFou2iPddvvgiZB+mEB2REPCARzd0DrNmOj1X3RpNu7qafkcmWHXMJ9yL0iXpt6Zl
	GjutTHzfE8W9eoIMXPwWCGuOKwor7rOlzvXC9QgtNl5KKDcH5HBBBvR1rW0/T/2Kr1qY8KhIeLJ
	XjVDwd9mQUm1RiHImCctttUxD0Qb9+F1QsMlh3xobe25pQqnI+5OQHAbGIGMCcZlIAIqfC6Aw30
	67MGTpBrKka7KvZtW5u1080+rqBCzmP2eX35LIM1xEUniRZoIFTg5RtLKl1iG2PlsFFVRVZ8Xq8
	3KYxVDG2WIREJBLdi9h+WoYj+hs5OWtMyhJoYbaFkDP+erD5lDZ/Wq2QmxqaNeV5ttZo4p2CQdg
	aEejiFeXN+qwmD/H9B/Wqlpn1WEE=
X-Received: by 2002:a05:620a:2a13:b0:93c:c1e8:6504 with SMTP id af79cd13be357-93f29cc9260mr1746353885a.23.1792502403333;
        Tue, 20 Oct 2026 06:20:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2a13:b0:93c:c1e8:6504 with SMTP id af79cd13be357-93f29cc9260mr1746349285a.23.1792502402773;
        Tue, 20 Oct 2026 06:20:02 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8185ddsm6032950f8f.29.2026.10.20.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:20:01 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Keerthy <j-keerthy@ti.com>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH] gpio: davinci: Clear interrupt status in every bank on suspend
Date: Tue, 20 Oct 2026 15:19:59 +0200
Message-ID: <179250239619.33509.15591478629051769601.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018170622.3406158-1-sahaj123.sc@gmail.com>
References: <20261018170622.3406158-1-sahaj123.sc@gmail.com>
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
X-Proofpoint-ORIG-GUID: SDF3KiqHP6D7pLRbID1ChDlW00OltHu6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfX0OMVokNilsIR
 4kQDZiLH+n43wo4JYhZS1HxNlksVcrHPaeWN4dCIY3vAOSxk0ldsuD4wTx2eRHG2s9frfx//CRh
 QitYAnkFRjo9gw3m0fnwKOGjwT35aA0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfX3cYOGTNJFjKM
 SACwgqno6LLsysjJjINxkDtxfRj0nl5EGd4Fryq7f3x2byrTfiwAU6Pe319qgaIMQUW/4tSfIeL
 JPezyA8XkrTprvEO6JpzBVVnh+sdmmK8esK2KrNrR07Y/c+WhZNzLrI27UZDWA8rTOecHNn14/1
 DjfPGwy93PyGTlC+OzvjueyEH2hey8VmYVqEbSwqsYfIjPXBZTjde8bNqi7GK6GBNSLRY5gDmyy
 CeWRFhYdkkRj+/6Qpk5i6RWwUK4n6tfWwUk4+w3a2NtWUQtcAAu7Fn5NwqPTBFkrJkTMBc+mlSB
 ZLS3dmpm88Dsd02/BZr7OhC0/3BvnAhCFJt0ONCHYZJvOjV5hf2y0ZMhfN5Dq+EJmV8Qczh4wbk
 iVTb7uk8MHUIw8v+9XgLKXA1p9WYL3qFCmPS7dw5Y3MId+x5kkWPitsgQtBgJD3l5rqCx0aRTiB
 tum3+TvDE0gUo2HrzAQ==
X-Proofpoint-GUID: SDF3KiqHP6D7pLRbID1ChDlW00OltHu6
X-Authority-Analysis: v=2.4 cv=crUOAF4i c=1 sm=1 tr=0 ts=6ad76a84 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8YrD1dwCgZ9uIqTg1mwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200053


On Sun, 18 Oct 2026 22:36:22 +0530, Sahaj Chaudhari wrote:
> davinci_gpio_save_context() saves the registers of each 32-GPIO
> register bank, but clears interrupt status only after the loop. At that
> point g refers to the last bank, so pending status in all preceding
> banks is left uncleared.
> 
> Move the interrupt-status write into the per-bank loop so that the
> existing suspend-time clearing covers every register bank. Single-bank
> controllers retain the same behavior.
> 
> [...]

Applied, thanks!

[1/1] gpio: davinci: Clear interrupt status in every bank on suspend
      https://git.kernel.org/brgl/c/800d7627f552bbf602a1736b638aee0ada3fbf87

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
