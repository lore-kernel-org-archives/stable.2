Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4337F015
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812180; cv=none; b=JzJiq9kuR01zJkyXblsxRo7JEYOGy4+9ADFd1WeAfj5Y/ZkPU3BaVneWXQKPiywQq2EtU0Cqbu2KxoPr3HnrdqOS6XLEzN/8OtmRf0aVsKaZe4IzNrA4W1HCi5XQ/tgavDpNRq0UKEPAiIElqxg8/4HkXMwTHd4NGX6XxUZJY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812180; c=relaxed/simple;
	bh=wZLW2XdypAhHvwo+GHAiZC6sjIcx7C3BCwY22tUge+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRuChZFiUq9eXXZSxA4DgL36ipgaS/ufIHpzbIqcqaUtAzr9s+yL84nfack1WxglrvXq0NJT2nwCwm8M7FkyY93DlVugC3y9q1F9wxhjCt85Z+VURPHj94Ttpgf8Uf5q4F2NNZH1Lq4nRIzjAPIa9HiOWqdyLlq0hp2ldcL+68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YWTnGaxX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=duvHiRoL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWTnGaxX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="duvHiRoL"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC0d1P2679953
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 13:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mX36Oh0ldjKH64bRULghbP9zkZHVCst58P7qBcvJdOc=; b=YWTnGaxXDF7dV0Xz
	fJ5z0RlKpai35YN/BfCDko0TuA8fMf5HQtijMWL+Lh8mhNWnzkF6aJB+y7aw2pCU
	HguhYficpp5M4Ef3UGOfu4z9o0PlpTOAL3RfJuTGMvwOhJf8QWCmSgLF/6aiDiGt
	wjaCvUhAhsN77vShkA77lIDQTuLB0HjPmlHZ2cfdlJ5f6n8q+SkXibBg0er3bTNI
	0hxNbdsENvG/1sIek8XxLio3dVfJHTaq4WxdppLcFiSpbUhaVvOyrZzX9UQ2H4SZ
	Kxl9ow01N54pH3b5BUSaHB05JR0jYf5KtOz/uRTVp50F1XJnKpGjsbfJ7Lz9bl0W
	TzMekw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1t5sa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 13:36:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93dea1b6c89so378097285a.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791812178; x=1792416978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mX36Oh0ldjKH64bRULghbP9zkZHVCst58P7qBcvJdOc=;
        b=duvHiRoL+rP5I2Avx1SZciIrprvnOSG2JFJec7v9VdXMI794K2JOF8VqwklvTARbkr
         gatmA7fOmdoc+wqLmdtpTBmjeyz0jL2oYALKKiBviI7NyOg+KWy6ggoU4Kpu6yKIGq6U
         4M9lUUA78eXfAkR1pTorcIQP2kyRqNkaAXe0hwTInJCVf7eA6vsgNcqbcw6d+w6WvF84
         g2qmiP5/tcGXihpLLgwtahh25H2PxDSGfk+npIyKF0XibhO2wcu6FGkbF1qzrCYqN3Df
         3Px9EdZ5eoPtzsYv2JJG42DDR5kTe8Qz0L16qRvE4kt0j7Clpa3Y6seGBfXE0kVD81wr
         V1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812178; x=1792416978;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mX36Oh0ldjKH64bRULghbP9zkZHVCst58P7qBcvJdOc=;
        b=v4s48TG8pxZ4gK0WQ81sNlAr5jV4nYwoCDuMKnRPf8sJgszshqmvFEpT/ypjlvxzyB
         ecQVF5jyAww1WTNV+fSQ/d1iq4r1HmAlGpCMP6NTnzK431ljzr6KPP6b7glbXUfvQIHb
         bjyPtlsY6qK61GVibQX9N5TfmgT3566zfKMjWD2ml1g2Arr/Z7YXrwmNVBO50R78RBQy
         E4KXQG2BfeMenZocrx6SUS1+0XzhVOjdrFofWHdKymvETtAJ34rwa5Ru5kcK9zmSYA0r
         pK50leVICQOwi8G4jiwED5KDfky+yNdjVeFPu+HPVdzUVTIDdgVYCzrjSjM/aE5eFp8E
         1drg==
X-Forwarded-Encrypted: i=1; AKwUvBzgdBiXmL59+x+1kRY5nzvDNk8NoXrf09mHV74/fXOhGvmqZwD3tVrx14l1b5xQ85cbws+SL7s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJphn9O/qw+UQUlAyfCxb5EDNXb1Q3J4z6kmRE1edi8xzJAfZjw
	jU7J+y4KGXebAAzLopr3QDjBRK47cANdPMHusK8zFoVQq4iru1Z55JkT9WeD2YjgO3ecJyDaVle
	ojRzzKcFPzRAuFaTN3V1yPxbKz5+f9qT8xmAFbgieBzdCTlkfnv2Fby0XAyoQhQFPibk=
X-Gm-Gg: AYBFou2VLKPX2+6fC6AJYdhHhEEWpKeVvEhXxZiD13guPaVAFMUHoc2125zQTgYUGVk
	WjQkDoFIutrTm+irTeD5yNdU7YE9ROlf1WrDqyJOMH53kREhnugbC+0w/R7IzpQbICbrETmcmjB
	+ARF3REBOD/lIpiHDmdhNYNj7Utbzshi1oImBg8FAjX+KAQXmes/WrlwgE0BF/InwR5Fb/msKkw
	/wbAvKhR2hIAVmXOlae8z4UrL4uIpxfiASthbr2xbvbRrGPq7Kg2IqJYoANEanXnx9Y+/5o+75U
	RAA9GpQq0V68BoV2pPfD9TqjPmbB6ZvAq7XJ3c5cK2eBBhEAC8RNSWjnln5ZLKugS/AeK20jRpI
	01XEGj+da4G9Tup2DUDTgkWOpSgk=
X-Received: by 2002:a05:620a:17a3:b0:93e:84e5:3c66 with SMTP id af79cd13be357-93ebd21ffd0mr1649957185a.40.1791812177528;
        Mon, 12 Oct 2026 06:36:17 -0700 (PDT)
X-Received: by 2002:a05:620a:17a3:b0:93e:84e5:3c66 with SMTP id af79cd13be357-93ebd21ffd0mr1649950785a.40.1791812176979;
        Mon, 12 Oct 2026 06:36:16 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19c8244edsm121124535e9.2.2026.10.12.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:36:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        =?UTF-8?q?Fran=C3=A7ois=20Roux?= <franzelfranzel@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] power: sequencing: qcom-wcn: power off WLAN at probe
Date: Mon, 12 Oct 2026 15:36:13 +0200
Message-ID: <179181217126.5143.7104145391205542787.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261004165124.4277-1-franzelfranzel@gmail.com>
References: <20261004165124.4277-1-franzelfranzel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fmNb0otQqG6y6-GAOBYq3pG__Gm18oXv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX/dLKiPNvobPX
 nw+MCOvN2ObHGllPBjLWqINRZVvjXkiC5JFanQuwst1IbJfvzuIcuHILmq0lP+Nm+bvTjJF/My8
 1PV7oWz6BY6hFsr61sOHfBGSv5Dddm8=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acce252 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=R6-RoArAaa4DRIP8ZZgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: fmNb0otQqG6y6-GAOBYq3pG__Gm18oXv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX4Z7isUP1RYem
 sIk/7BKxLSTTU1AuAwL5lsnXJTwqRGMl3WIpcq6ovGGHT6tIHhTkTiGJAl0JgY1kYDJXB2+BrtR
 lzrI3/QkvZMU0GdkHubP7jxkiZ8ptLBA9JuY8/uQWoaGXGPeks8ZjkZ9J8oLF0g0gJ+UCQUBGFF
 E8GE47eSBt2Ko/Ty8q8AsXDQ0HDKYmi7JG3gCHXkEseskpWllEx0FubW5liu8se3DUlKkbSwiSa
 p76Syc34xo5aCf50YHiAA0d0IgB30K8Tsi1mDepp0ADhPpP43DgkOSIRSPGmuBSkS8tpnl1wdkU
 vY1bp9Jwvj12cf5JHbvfGGAFbCSWQobFkCB+hQ5XupkRcURFAtjYoevYmOPvI866V9hbCt+nI2y
 QV+ADF1raPiOpjTdgezuO+pPQ+pVK50Ok5d/3rrJkoJL4xYkgXS9tWJPiWCDblA++5DoZFPjhd1
 p2dP8J+7leJyE8Luyzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120054


On Sun, 04 Oct 2026 18:51:24 +0200, François Roux wrote:
> The WLAN enable GPIO is requested with GPIOD_ASIS and then kept at its
> current level, so that a WLAN module left powered on by the firmware is
> not switched off. The FIXME explains why: toggling it would take the
> PCIe link down, and the controller driver could not recover from that.
> 
> That reasoning held while the PCIe link was trained before the
> sequencer probed. Since commit b921aa3f8dec ("PCI/pwrctrl: Switch to
> pwrctrl create, power on/off, destroy APIs"), qcom_pcie_host_init()
> powers the endpoint through pwrctrl before it starts link training, and
> defers until the pwrctrl driver is bound. That driver cannot bind
> before this sequencer has probed. Power-on therefore always comes
> before link training, and keeping the firmware state is now harmful.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: power off WLAN at probe
      https://git.kernel.org/brgl/c/dbd674ccf30f66f5eccf637964a93910df8dbf84

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
