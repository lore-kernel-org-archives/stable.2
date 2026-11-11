Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434617;
	b=qoTrIci/jGA8syCYk0iCO2UOQueXGs6eo2lPpACNh2XoemXrlNRkZr5b+82MSFHfs/a/
	 pKQXSzI2O3T65IushWsju14jn7rA4ZZkR9UpjXGqUFnAPLUmw+lUyxJuVdJy15ZCxK3MT
	 K2v5kUPorLyX+celwCSd+Eie6o28OoY1KuA2MjuVnJu7/Nb1EGFwSk5upOOeq+YDbei+Q
	 QET1l7jiveNwA67bZWsRnqgz/0ePiGoThjl5KPaINVeXV2T28qbgBkF7WCEQVnLi7rA9g
	 QtnsRry0lfDliiUq9NLGr1+jXH06bjqllQ7NkacTEeTAbPFuesePR8HVhcwnEfWaq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tG3Qj2BHBv5tCS7c4CzMx0BdK4JtSpKfyOtOUzoHYP0=;
	b=FNZS2L9M9f0WvSpYJ0veTxLtrPh9pLPdSU+/fv4lSLK7yx4LyDHOztExjzesiTepTCYx
	 Ix+WxdB0U/69zVtsMW7EZlpndAEsMgXJrUO6c4V1+aBjDzfvylbsPuXXIXmkmifOpr2pm
	 msGTzykKjkSKXrNRzjGRsI03lbTDI91GoYJe8FmctaDTcacCtELaxSnxXZ66aoNJ/orGH
	 +oHuheSwhLwUB61a5rUiBMdY4qKqtds6VL/CXXu2aPphlUWjmMjUsHEOS5CUSCK1vU4WB
	 eAsE8GopxoTj/Vlzomn3a3gr3TdROTAcy/Yw3BKB+GvJ+lo1TdCRBPV2VbekW7JOxFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6tumB6x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB2606B367
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6tumB6x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ECA1F00A05;
	Wed, 11 Nov 2026 22:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434616;
	bh=tG3Qj2BHBv5tCS7c4CzMx0BdK4JtSpKfyOtOUzoHYP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P6tumB6xpkonLMh1C9rTTx3dFXcBjbpfuSWLI8jo908AZoezKSXKqcaXzVxG+DURl
	 j/ijT0qqmp5UmGDM61rSM/8XopMYvr7bm7150WMqzycNfwSSg+N91tohx1QQEtfMzi
	 US3SIAB5v0Nwi/6bxkkzQLKGwpnXITr/JUdJ2ay3AxZYZ+IQ1uduKfWM8cQ0D9DwwI
	 Fy81+ig4M8mQhIAgVSZr3CfaHPHugbFtaPZRjNgN2IDPLEFWaQDmVLFXHjfWa47zvV
	 29LEj0BYXsK2j0kvNDWcCAuDVOMJCvcWdaIkX94YU9h+6xyKmcDDiL2u5AJRnfR93a
	 s49f28PjW56sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ravi Hothi <ravi.hothi@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ASoC: qcom: audioreach: fix module cfg blob size handling
Date: Wed, 11 Nov 2026 17:03:34 -0500
Message-ID: <20261111220316.4086529-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051502-failed-6.18-e21fb64a8c4a@kernel.org>
References: <20261107051502-failed-6.18-e21fb64a8c4a@kernel.org>
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

From: Ravi Hothi <ravi.hothi@oss.qualcomm.com>

[ Upstream commit e21fb64a8c4aecae31ec63f994423ac944705c3e ]

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
Link: https://patch.msgid.link/20261023171316.819857-2-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ sashal: Adjusted declaration context to retain the existing non-const mod_array pointer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/topology.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index f8d3bb83e3b0d..93e40a05920f7 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -312,22 +312,37 @@ static struct audioreach_module_priv_data *audioreach_get_module_priv_data(
 
 	for (sz = 0; sz < le32_to_cpu(private->size); ) {
 		struct snd_soc_tplg_vendor_array *mod_array;
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
 
-			pdata = kzalloc(struct_size(pdata, data, le32_to_cpu(mod_array->size)),
-				       GFP_KERNEL);
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
2.53.0

