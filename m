Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775624;
	b=OWUeajUt1yEDIInHyNLnvvqhswvn5uiTTBf7Q6Zbcm01joMcasbatdLzgltEzQHxs44w
	 8hnZRer4UjStrmF64/FndJfIu4le+h+Cn5IEcteqUU70KLhXHXumDtpfCuY0YlIDul3z8
	 t7WzQZ3KYm2GLyW+s3Ao4jMivDJq2KEpSDZCnKnY4fO3JxMXPjrTBueLqydeh0ZIFhncj
	 QwECB4I144nfIFzZC9xAmR+wBPqQP6XFGt14LZoHhOOg5slkBh1vT7cogBIBSYgvJTTEa
	 bfN7+HfA3rBOfbeedz+6uPt5EFMwatiyMvgo+WUJLdriKmfP5UukA/wj0nVIg59rcRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=azg3XSvMykpTDhpzyYQMK0xeWLWeWs6SeZBLuvOTxGc=;
	b=yBNBJkjcAVKpUQxmGSDwmM74aA5WKE1/zpM8HjOSN/v2/qj2hTmx93lr90BZ6Q6hKTeR
	 TWSagZ1a/xKop/SpvQ0jfvYHWa0p8AUhIVBte5NraFqqOfYPIECdRhznBb3K1gRlwLP9P
	 R1lL8QwPlLe+cXz7IoMLRbZVtvtqwtMUJHQ/eWJa4J9Mj37atCsOO68n610d+XaByVOH+
	 v2oSpYJjaY36TiKnzksefD9NoC/MQch2fPyBXQ5OGeL1ABsFaQqG6FrHaOvDCCz9JKT1X
	 xUuithgG0AIOZvYfb1NafdskkYO0+WNUk1sg1JIDaHVKeG3iCZoGq3T53SH7ZiS+HyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lh1J3H32;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YVJhbyZX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1B0606A327
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D1B0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lh1J3H32;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YVJhbyZX
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6t1s1492268
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=azg3XSvMykp
	TDhpzyYQMK0xeWLWeWs6SeZBLuvOTxGc=; b=lh1J3H3233uDUfWpmdbmM52osDB
	lgKjpeS2cteLoji4ZRksboUTQKKycMhktVCqRUkY74qQ8pVWeUrB7FVfKxLyvIUI
	Hk2mt/QgnOj6wjliwkUi0mb8kNFHJd/EN85aYyFZLz0gQwOloJXdvS3xYX5vRSf1
	pO+NTh78aNXjkjQ3oHILKZIb8uhvwLOqcH8hR1dtLM7zH5rG7tQG601QgwovAu0t
	+AH6MlgjbmhsKvvbXr6UcOrRvKNrr/0vKUoxw9aql00U5T7h27i+7Jv7lQ8hxzIu
	2Unk/a/bxaPflh7gBsBr+P4PRdPEOYxdf+u8tUBNpP/V1YrABBo7+54vkxg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmav65h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:13:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2373e9b4so119291485a.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792775612; x=1793380412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azg3XSvMykpTDhpzyYQMK0xeWLWeWs6SeZBLuvOTxGc=;
        b=YVJhbyZXoLA1coUNuoHKBti8dh3bsGg1rxa2kSnkljc6VWA9A1CiNLsnQZQ5mBZ6co
         2hm0K0bQXkvWHtpj6O4l3IZVNuj4IzLYcpbbsHonajgh/fTUqs7JSCcNfcBcl+LQvgDq
         tfw35qVZUgW/OKRcvKvteyJFkJPJDAX3AYowmTB1K0WvK7f1PVgKqTaVbqNsltJSvQ+I
         lfPKyyCXKDRRUc5nSnyyZRNVFZ37CPjbX5uLntrFKYRKjkpr6YjEmr6i6u/r7EhPflTc
         Yjv/pgxVaI2b1uzPZ9ts2LSDZxpAi5q3MCVN90SloIX8ShC0X3H+yVOOIu3I1qn+JnxE
         FUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792775612; x=1793380412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=azg3XSvMykpTDhpzyYQMK0xeWLWeWs6SeZBLuvOTxGc=;
        b=zBPvGgFFbKp/Ywkr1LdSwe3cCSamB3XMt8tyMrmjH00ppgVVym5bYxVdeeEnfpqYfN
         q1TjcA3D/E2TBcPo2mn+mW3bsqf8oEeOqRUrQ43MxxZKFafYWxRLb13H2S82pg74Gtk/
         SwLa8ahfj//g8Jignw5MqRkIby0c4+/6xrLwsxD6OitU0diP8SN1TZ3ZuEumg4AwgHz9
         tJqDezVEWsyU7wwze1Me2RUyx6wFwn+6d9GUt0UhHa0Ritc6sPbvliIVJ/IV6B9ZrL2f
         xRxdvWYPHi/x5kaZrebRbAo/As0ZJEtp8IDLTKkLeBq0fkb2kRPI70ekc29F6XFGkWm9
         pM/g==
X-Forwarded-Encrypted: i=1; AKwUvBxMCWpEu5QG3RXp0Hi5V0jNm7SmPdBtTsrvsjKBGeTKNkpw8XTBWoMXX8CdAnSGVH8NT1i7DUA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnX8Xbdgez5n+wQVmbI95t4pnBV7Y+pH+0SjKfV0v0qLhrLaxr
	lqJQ0AuhvkJmNRo/bDfAU0VMnKv3eWcOIZ/XR/cV1I7dVnmsvXneZfBM9siu1Dkk9owokk6rtHA
	ZvpUXNbmQYIBYega1d275WXTWiQaLnxhAXR4XOZGvMqQ90dfDj8NTS2Z7dac=
X-Gm-Gg: AYBFou2B1JCQJbNCa3bHGQgCFXfGNV1z1Icl6rxECJm125+nLQn4om2Xta/t/vRHuBE
	QAR1y28M1XI6MWUMvWos0RIq8UGege+djX3ofn22cPuHDQbW/6NyPMeiQHBagTOx0+5sIWL/OXT
	tDe1QyVEWftfssk9lz7TJi+qAI2M2pNxqgFCSv8EJZCMzru56nvftfEw6PbBXVo560MaRLy5uRG
	HxWh7BDMbVbNWFKZrgROBG/LQaG+25nZrZSwfjuwwLPnUY2n3KLEfG+5nUcPrvgdV8yIhti/C30
	f8JhwN27UT/Pm1EtqEEwregzhD91HEVm8DESz5MgXnTtoyLDVo0opoPgj/c7nMe0qklR1fWjF/s
	fN7Xx69peG4fV
X-Received: by 2002:a05:620a:6011:b0:93f:3646:7a5e with SMTP id af79cd13be357-93f6f9e0c43mr534100185a.64.1792775612096;
        Fri, 23 Oct 2026 10:13:32 -0700 (PDT)
X-Received: by 2002:a05:620a:6011:b0:93f:3646:7a5e with SMTP id af79cd13be357-93f6f9e0c43mr534095485a.64.1792775611626;
        Fri, 23 Oct 2026 10:13:31 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4104b5sm1043841f8f.36.2026.10.23.10.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:13:30 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Ravi Hothi <ravi.hothi@oss.qualcomm.com>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 1/7] ASoC: qcom: audioreach: fix module cfg blob size handling
Date: Fri, 23 Oct 2026 18:13:10 +0100
Message-ID: <20261023171316.819857-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023171316.819857-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261023171316.819857-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb95bd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Fq9-307z7DJWB1LruX0A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX3KdgyVm5vAS7
 pIP1tL1ahbl/NYtJiF8YIBn8CHz4fNZPFB8lskGXkVnNlNvGwFZwmvd+RXJgKlxq/WRIkxmRl0w
 1jRjog3q5Dug0+40x6ewookltR5Or6M=
X-Proofpoint-GUID: Tbwysu2gKKI1dFnHQx2csUdUTW13o6w3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfXwLwnco3m1yio
 IX+IC0kMAWFuVQr9P2YKAgf978A8qYlIhmSFgwxiz61Hypw9LAIVjk0zDBsRwOAk3xyDxtJy9TW
 9n1Tg2UrJ3YFmaCxbBiEMnWM1v+8h/qOqvRx16duZPNoirfP4/fguPo5Y0eiGL2P5sTnk3/hpb8
 GXwQKx3EnDSaldaeHBZ+k2kgsv1M8NW76tcl47MMo4RNsegMlDfJlekMakXXfX/+0Sg77OHyiOT
 tGomoWYcqI1j1jxKhcOPQoDFkQNkzuY/4NpZ9gYczwtkDhmkM1soam93zjCvqQHyX5bV/b3qBYJ
 qFVeA71ucAXaGfcxCzQza+9e8Ab/OmY4qNxPMO23l5EOGW8Pnjv/RhDBi2yxVjlethdFHEQcFcI
 zoNN+JUHBMXpvYeotJ/Ez0ny5cUFQHbk20Te6/O85xUQLX3E7elUPOGNzZmQRbL4O/02FBGVpfV
 GAJhTxyREWutsi7uyPw==
X-Proofpoint-ORIG-GUID: Tbwysu2gKKI1dFnHQx2csUdUTW13o6w3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230067

From: Ravi Hothi <ravi.hothi@oss.qualcomm.com>

audioreach_get_module_priv_data() passes mod_array->size, a byte count,
as the element count of the __le32 data[] flex array. The allocation and
the copy are four times too large, and the memcpy() can read past the end
of the topology firmware buffer. The size is also never checked against
the private data it must lie within, and a zero size makes the loop spin
forever.

Convert the size to a word count, bound the blob by the remaining private
data and reject a zero size. Also check the returned pointer before
storing it in mod->data, as an error pointer there is dereferenced when
the graph is opened.

Fixes: c7ed4c2debfd ("ASoC: qcom: audioreach: add support for static calibration")
Cc: stable@vger.kernel.org
Signed-off-by: Ravi Hothi <ravi.hothi@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/topology.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index faafbc5c0ad0..612d8f03e6e9 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -312,22 +312,37 @@ audioreach_get_module_priv_data(const struct snd_soc_tplg_private *private)
 
 	for (sz = 0; sz < le32_to_cpu(private->size); ) {
 		const struct snd_soc_tplg_vendor_array *mod_array;
+		u32 array_size;
 
 		mod_array = (struct snd_soc_tplg_vendor_array *)((u8 *)private->array + sz);
+		array_size = le32_to_cpu(mod_array->size);
+
 		if (le32_to_cpu(mod_array->type) == SND_SOC_AR_TPLG_MODULE_CFG_TYPE) {
 			struct audioreach_module_priv_data *pdata;
+			u32 nwords;
+
+			/* size is the byte count of the __le32 data[] */
+			nwords = array_size / sizeof(__le32);
+
+			/* the blob must lie within the private data */
+			if (sizeof(*pdata) + (u64)array_size >
+			    le32_to_cpu(private->size) - sz)
+				return ERR_PTR(-EINVAL);
 
-			pdata = kzalloc_flex(*pdata, data,
-					     le32_to_cpu(mod_array->size));
+			pdata = kzalloc_flex(*pdata, data, nwords);
 			if (!pdata)
 				return ERR_PTR(-ENOMEM);
 
-			memcpy(pdata, ((u8 *)private->data + sz), struct_size(pdata, data,
-						le32_to_cpu(mod_array->size)));
+			memcpy(pdata, ((u8 *)private->data + sz),
+			       struct_size(pdata, data, nwords));
 			return pdata;
 		}
 
-		sz = sz + le32_to_cpu(mod_array->size);
+		/* a zero size would never advance the walk */
+		if (!array_size)
+			return ERR_PTR(-EINVAL);
+
+		sz = sz + array_size;
 	}
 
 	return NULL;
@@ -611,6 +626,12 @@ static int audioreach_widget_load_module_common(struct snd_soc_component *compon
 		return mod ? PTR_ERR(mod) : -ENODEV;
 
 	mod->data = audioreach_get_module_priv_data(&tplg_w->priv);
+	if (IS_ERR(mod->data)) {
+		int rc = PTR_ERR(mod->data);
+
+		mod->data = NULL;
+		return rc;
+	}
 
 	dobj = &w->dobj;
 	dobj->private = mod;
-- 
2.47.3

