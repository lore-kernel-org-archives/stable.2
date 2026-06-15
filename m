Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1540E8D2
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538638; cv=none; b=RmToGgO8gHfqcbnk8yPJaH1jpYVCsbMkZvvFaGJ8dUOi+m4S2i0LBUALHIip9f8Iue/IckNg/9v3Yw+Wp4r68ZofeQFWllTXuFyQgYag3dJI6naRfgnQf1dDG7h83QJPUM38lYGtnyV7aSGTkyN3WpJp+QToABvJ8mNHps3IZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538638; c=relaxed/simple;
	bh=jQ3wLVE7GjY3KrZpgyZfT+6PvlaYTHrdGrhp4PJA/FE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8dTBd2tFwD5ZGea5sFqy4D4D0Mw89LvG0zI2Jz8YefniG9v77aXiWYbqG0MNSVHL7DGnseoW6ic5KCQ9/ZuAoLINaoSs0syqXMNYkByM1iZBAk91ctB47jAE+/i/b7GROVFZF9kZo9ppb4rP1I4tXMNubf6StEq38Mph4VUbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hftmdIKO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VLEoMAag; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hftmdIKO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VLEoMAag"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFhP2r430451
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DL3WkxaAIXpqgOzUtt1ueuSKLkNRCCjmcACm38hAbmw=; b=hftmdIKO1iYG5q9R
	txKvEz3EJl8Nps5FsUNOFsdRrKYPakclaekoTbFSc+Gx/VC+/o/Ml4us8F7alC9S
	zR0kWe7yMcsL7fPmYOP6GTeOA80zIMUh5CznbmrMqcP3Jt0EemBDuQwxZ5txaSgc
	B2BI4D2f2KUDbFGW0mC7HeX4SilS7tDvhI7d8C58wA9CfIHTzLadkkHkYq+Fg/2y
	F5vpqpj3eDMMsWzEYpKl4kHBRZQs208xZGhn6Jb+fM4kFVGzEu9u3rIoQl7B4ZPe
	/yTvZu/ZDrHP7xGPMpE7jL0lhex5hYEu6JxvyjfFqHyynlcj9I3BTFKPabNyn0kP
	EJnlGQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteyd9hpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:36 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963b11561bbso1269053241.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781538636; x=1782143436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DL3WkxaAIXpqgOzUtt1ueuSKLkNRCCjmcACm38hAbmw=;
        b=VLEoMAagVxvyhduVPED/o+hcjZoafVDG4Zgbrndrj/h4a3/xf2azYJ24ZYESXIwVoJ
         ve9kGbv1vhUdNEBX9jDsnkQ66mRsQBmG0spKxn7iaVR258Nso++4qco9AfeFYn4lwMyW
         OtnOEjydAuhi/P6FkkOl5tFj70vcv1yttijOFLj2CZdqbQbBGxBntyAPkR7gTl4rRF9n
         tqQmK7XSy77M5drfpkj5G3ThxLtmMPMP9iS8Fee1Yt8cXSkpnSwULz+QU0T+otx07gdG
         YIhq5eycRJOY4jP9NKVQJBrl/+A3rqJWCMstkFDXHkxmcoEgKjRV5L3INKXDGN/fKsav
         z2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538636; x=1782143436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DL3WkxaAIXpqgOzUtt1ueuSKLkNRCCjmcACm38hAbmw=;
        b=ODBWi4KNZdN0U9mH9LpN2Adcb0cMAcUtadh7NHFYns291VTQCE2lyC5nWiJ40fYXix
         RDxuN6T924/d8owl35HJWOJeuLTXipcr2k8MElhBnkEYFsyAFGJDt7XP4zjsV3aEQ5Ml
         SNmaz7AA5Ss6R4B6v+s0WW/eZQOsDTprK/R54YC20jSbn3L4CcVt6Ablk85EQh2mG5Kv
         AMXjRGI3WBVVCHPsKPe5gdGcP2ggy+jSlzxBuF3IiQt0BxF0bF8ivoZfKXs4k8AJgqxx
         WMWRB6X0nxxZaYHrCZs9r+cZS8nnuRGPF2+bpOI/pOViplOWnJLGcstBQ3liRDW76J7v
         oyMw==
X-Forwarded-Encrypted: i=1; AFNElJ+WPwrEr4pkV01LXFr5rkP2iq2j5gUGsu5731swx5gMjuN7x8KD+SXvAqawYihknMN3HfPduek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyywvwO67j82+wYmZo/izPO+rCTsOjz3COKXtU1wuh6pJdFq02
	Bl1uqLYRAsuF6XvddYQbvGujxMKz6mdCkAVMGOaZGNRwgp8JGNVbSGJe647067nvvfVaGh/LrrD
	jRk6W6j40jo+2ZnTCV6J2gfBmhMcUTQeI4ywDlvSfZAlsAWEXvOaW9FyRIAxESi7XD+IPrA==
X-Gm-Gg: Acq92OGH5FQeBXdB7eEbDKhvCP7EReMEQo0JYul27UsMdlI7uuSx/zfKYWBfljdhJCd
	nwxgX/80TaF/0NHLUfE2X1cAe4UA0JQbCysKDoYaHlAjBf+hOcL+ina/psQVqOxVU9Ur8s5nzaO
	RfIbeDw5Wgy6kjO24u2PLTRAVg5Am6ukKfrFJ/Il/wr0Q0y46v3EBazzxBgFH0FgfEEm4FYpImy
	HFjZV1LY6FOJqpgvaUFJCTs4V9jIf04GC9I56wkf+LFHQNmDWzj9minZ4xvjYfWYblBx6rBxlOZ
	ThOq9FLsznyhADJmos9JeTrAmxkLsgYTUCZdK8XZVBa/nj8QGp4iDKCF7rsMqdANyQcSZmfvz3m
	vmBUWhqXduIMbe46U6qIkXHt9jSj5mYhp4nu+BsfXfT2sgb10cbU=
X-Received: by 2002:a05:6102:5812:b0:631:23fa:38d7 with SMTP id ada2fe7eead31-71e88c56801mr6702991137.14.1781538635608;
        Mon, 15 Jun 2026 08:50:35 -0700 (PDT)
X-Received: by 2002:a05:6102:5812:b0:631:23fa:38d7 with SMTP id ada2fe7eead31-71e88c56801mr6702979137.14.1781538635163;
        Mon, 15 Jun 2026 08:50:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:7fe3:eaf0:5a0b:2610])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f450sm38643032f8f.10.2026.06.15.08.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:50:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 17:49:58 +0200
Subject: [PATCH v2 7/8] crypto: qce - Use a fallback for CCM with a partial
 final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-qce-fix-self-tests-v2-7-dc911f1aad42@oss.qualcomm.com>
References: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
In-Reply-To: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jQ3wLVE7GjY3KrZpgyZfT+6PvlaYTHrdGrhp4PJA/FE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMB8zdAFIxUHikN73T7KAyXFU5NTKujwi+FmJj
 9Rv5g4joB2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajAfMwAKCRAFnS7L/zaE
 w2RAEACygrV04TmSEgKNzna+3CMJoCsR0G+gJIIImhCtU2OJBJLsg5ksC4DM6kMrPzOifVoMPi7
 Je/NVIdO8jKqOnpWXfw1vK6RIU+TnBIHPAo8zwDl5RYFawd/R9aNfwkq8n2vv4ImmeaMJhdIDD7
 4+nnQ3/xuTVZA7EEfhJn6FwPZ06g+dntFrm0ajut945qIFmE55Ut5R9gb/5+utrrrZ8jklitMmq
 RcUITJcgSZpPI88B9s1IJggylLCFoTpeSeeN2Jh4cPPY6vdL4+JsNLTZIfybVuvf3fROq+xGdC2
 yanPVctQTPDB6HFOGJVzRzlwGsArdGC3CyAHkuTqZQwLbgeQMVvd1ZTzqXqSdeM3SOSpiaLRpcS
 GZOmIPgW7r7Jdr1BAnsGpruLuBR8rhKtK/Ggjdfl6SXKa7mGZ0Iwv+mDRpC1zSlHqwwm3gqLLvZ
 WyZH4PHAAWtvXMl+riDsPjjGJwfwNf1Iv7glgX9xfn9N/LW9RaIPKFy6UbBOBbqN/1K9NzaJfdi
 VLkFcO9On2FuGfALcjheMSC6yrDTLyjnZF+Us7Hv60xQFK3g0H4EoV0Q/765Md7rZjq84KVcc/a
 NptjcPHIURtJcTLgc0qKDXQb8DbT4XR1SM7znD7DlBf93lepI4BdCiP5QjfssXtpTZqQu6hE9ji
 NeQXPgKORQpAzPg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: A0pDtav4AB9PEJV7f5yTf_WNmUhZjlny
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX9Ee+rw1auXJZ
 iVn2LrYwmdm7pRuQDW2Qq4UsWfm8EroLR0Sj+weJ8A3SDFGAPlNu8luxpav16MEPrODsJGqPUXC
 f90bR1esMRANeA8i3HDRdi4m2V0UaHo=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a301f4c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: A0pDtav4AB9PEJV7f5yTf_WNmUhZjlny
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX2LSL+JPTKc1r
 UYFArr2kNwY3TM77Vyh6ZkAbXrp3lcjJJj2cz2mB86EvgWgBagQTKfo3S0om8HOEoWzUfVOeKOy
 WIsuGiJ5Y0ju+eXnJfpvVl9/uqCxFEx09XMN7EXbs7wctizdv+iwXrC8h+P+LJA4bKoLiRfbud5
 hLEnvI+0Gx8DidYxt3qOap0Wm7rsE26/9KFHd7uPWwFU0OCF6gan9hgzSafDNldoazyxycDbVYP
 vjlGl0pEgf8DAClzXqYadCUN/zfYxBW05OOBeQMNNtA87PB+PhYs2yi3MjxPUOL4mHLblWXuD5+
 Pv75uhPOhe6mpGrEE2jMQzs/jzN7YXpL5mdSTpzt997N7apLAsZUrC0z82nzicKF7Ev7Sdcs2ck
 WFJDFTrls0BEaVkf8v1Q2MAd4LlidYsKtZif/zDO2LxuLfGWtKgdK6U7iFtZqAMWWqhW6fTsbSl
 jqHfbQzl6iMYLrs4lNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150167

CCM builds on AES-CTR for encryption, and the crypto engine stalls on a
partial final block just as it does for plain ctr(aes): a payload whose
length is not a multiple of the AES block size leaves the operation
incomplete and fails with a hardware operation error. This was caught by
the ccm(aes) crypto self-tests.

Force the software fallback for CCM requests whose message length is not
block aligned, reusing the driver's existing need_fallback mechanism.

Cc: stable@vger.kernel.org
Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 6a511e5d7f6290a1df0093e463f39f5f2db25f88..46d3e3eb53b271e2ce755847bbcc83f81b9bda7e 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -516,6 +516,14 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 			ctx->need_fallback = true;
 	}
 
+	/*
+	 * CCM uses AES-CTR internally and the CE stalls on a partial final
+	 * block, so a payload that is not a multiple of the block size has to
+	 * be handled by the fallback.
+	 */
+	if (IS_CCM(rctx->flags) && !IS_ALIGNED(rctx->cryptlen, AES_BLOCK_SIZE))
+		ctx->need_fallback = true;
+
 	/* If fallback is needed, schedule and exit */
 	if (ctx->need_fallback) {
 		/* Reset need_fallback in case the same ctx is used for another transaction */

-- 
2.47.3

