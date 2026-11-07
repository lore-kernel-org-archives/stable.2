Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046504;
	b=ExJqzHVpxc6FX2i8Ng3MT5OzbnT5TSa2ZLw7lMjDZ1kHXvs9cjkYD3CLfCNIIWD5N+QN
	 YXa7WfRq3ZFAFS+R+K91TmZOkKYIqQ/vBYNz2cMFh49nndIWCmSvWZTLjol/9ud7qO1aE
	 QGS/Gi3sdCXJqcmUhZzci/pyroojceYnnU/ZQAdzeptbhkHv5c9Wu5JSLAM2qgE/5G6cd
	 JP8bgLKFWog8M9NVlLi8wqiFwZirRvPODUYj2N2hXBn4eHqJP9QM8ALrbgdwxC8Gx6K/8
	 ByqUJC1RoyFIwtb7FxFtXcHIdfPn4tgMTFpayMkVZkyLPo8AD8Jb5oQdEn2iCx+lqBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046504;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RpUOAWO9jD3EsIzNaJ3qKVjlpUFSkIMV08l3jtqJBcI=;
	b=J9l17DT+udf1sV4pbxMs6gPdGtosBL35Ws1REY3GWcrACMj6/nEVCkvNUFnwqtQXuAgd
	 5sgc2/rBnNl/QxDh3cj0RZ9emhxga6cKmWAtFbTDTQUoWsHe4Yyc0xYNk46ZnS7EcEU3R
	 UyrHwhpUm9wx9eJMdxKJuLOkh8rqcXtFLVa/1aC36NIIafGUlddRo1zHVEhytpbAE+DEb
	 joGAdV4GjkUO21ZlNo+QgVegM5wI995P0qhnWLQvKdv87YT+PDSdVy7K8uyoz6te/GcCV
	 0TcMTKHGBCXSMVOrVOp5nfY6u6c23pOeLvg0a7567mFqaX5c7bvXwpNB866rECPAPag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n0i/av+Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B8606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0i/av+Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411E81F0089F;
	Sat,  7 Nov 2026 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046503;
	bh=RpUOAWO9jD3EsIzNaJ3qKVjlpUFSkIMV08l3jtqJBcI=;
	h=From:To:Cc:Subject:Date;
	b=n0i/av+Yev5oFRZu6slm4bSHInhiuAyPh4dmxLcHUbD7LwylrB7/QLlXA1a0b8vJM
	 DiI5KWlUhg7sDNKH0eRMJA9mJ2LipM2ZrYyYtPDFyMA7PLALWUQdWdewk4eZPNFiG/
	 6Tn7rPKtsuDrVgnD76IPmD7vsSGcH3anQs0/mKJ6ZBAtJKRHOugoGQnz49xUxmSE74
	 nLL+6N/O3WvLoimqWRMab/48Xbrrwz/5g+hfmUVqCz0ZxvqJZOWY5QoZR27vIBFOVm
	 /LME1096b+LgO+fAyConxDUeeMmDKEOb0/XHIfk6C6P9IwUfM0KNdv6S7iOI58mNQR
	 chTZeg0DgdkTw==
From: Sasha Levin <sashal@kernel.org>
To: ravi.hothi@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: qcom: audioreach: fix module cfg blob size handling" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:02 -0500
Message-ID: <20261107051502-failed-6.18-e21fb64a8c4a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e21fb64a8c4aecae31ec63f994423ac944705c3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051502-failed-6.18-e21fb64a8c4a@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e21fb64a8c4aecae31ec63f994423ac944705c3e Mon Sep 17 00:00:00 2001
From: Ravi Hothi <ravi.hothi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:13:10 +0100
Subject: [PATCH] ASoC: qcom: audioreach: fix module cfg blob size handling

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
---
 sound/soc/qcom/qdsp6/topology.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index faafbc5c0ad00..612d8f03e6e98 100644
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
2.53.0




