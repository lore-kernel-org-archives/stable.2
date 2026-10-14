Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88042427F85;
	Wed, 14 Oct 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983297; cv=none; b=eDfrOiQZp3NtsuRyI/RpXw1e3sI/0J5WSipJKhvNekNCkQcdRpR5X3PvQOqlU0L5wfgkith+QJaM0TB6C+FreaZT5gBkCmbENCBbllj9RBSI/78ob/tZt6/2RfC58gdUHT/waP65DXjfmAElrSwWx4KDuAOlcOhDZZ5SLxIOXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983297; c=relaxed/simple;
	bh=LDyTaQRpiNCLGifw3ysSkRAP6gDTaE4urTYu/9BPkSg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Aom1GO/s4qDIh3+ThlXJ4w+3pN9EIGHyo1h/YWgKP6upd837gCyecYAtoZ2n8dkjFnRtiTeVuTK2BN/SDpZnND+rGTLNuXcoGXm/1WbFhlR7peWvztwNhJxr3J5glYGPV26q985SGeRK4aydu5zYIs3LeGAcOKz9Pe0MZfH7AUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=WwvsDZf+; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="WwvsDZf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791983292; x=1792242492;
	bh=BqTh6n19golqx7qGe+8OlPh2PcFhJmLhCol8IvkKblk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WwvsDZf+plyKGVPEtOr/ntTl/1wnRRNjTmQhXR6/STMP5nd4dWrmrF/IWiVCEOrd2
	 uqLTzHcKh8ZJBMUW8VHfsiTwNWpWDbTOMTgR7K1NW2P/E8Zuz+COCrLyBkQ5D1rfBo
	 GUxACnInCDUkjhgUtrTy4k7gGpXK9ibaay4VliDQbIN/QtorcI/X4TLbC8CgfCLxvl
	 S7V4LsKxMyTmkUH1yiER8Np3hYuezkSXGr8TsM6zCt5gV464hVsz06Fcl0dtPN2ljp
	 82nktkD13JReeR+G8j62/Xrhn+PW86YnHU/KU5ujSU3jHVgCdhNevSis6aTeXs0sPi
	 Tv2LueLC3zVpg==
Date: Wed, 14 Oct 2026 13:08:08 +0000
To: Andi Shyti <andi.shyti@kernel.org>, Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Daniel J Blueman <daniel@quora.org>, Sasha Levin <sashal@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev
Subject: [PATCH] Revert "i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL"
Message-ID: <20261014130805.48840-1-birk.skyum@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 3fdfce3c61c9a6a7f540e0c76ae0eecadf5d47a2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This reverts commit cb97bf3d4f91453b881acaf8e9f0cc47bb40b604.

With that commit the keyboard and touchpad of the Lenovo Yoga Slim 7x
(x1e80100) are dead, also at the disk passphrase prompt, on 7.2.9 and on
v7.3-rc7. The first transfer on their bus fails.

  geni_i2c b80000.i2c: Bus proto err, noisy/unexpected start/stop
  i2c_hid_of 1-003a: failed to fetch HID descriptor: -5

With the commit the I2C serial engine clocks read 32 MHz, without it
19.2 MHz. A fix for the 32 MHz fast-mode timing is still being
discussed, so go back to the previous behaviour for 7.3. This brings
back the hardcoded index 0 in SE_GENI_CLK_SEL.

On v7.3-rc7 with only i2c-qcom-geni.ko swapped, the keyboard is dead
without this revert and works with it.

Fixes: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_=
CLK_SEL")
Reported-by: Birk Skyum <birk.skyum@pm.me>
Closes: https://lore.kernel.org/r/179173732257.29426.7905170638383807320@pm=
.me
Link: https://lore.kernel.org/r/ae03e7a3-75f1-42df-b0e6-0e64358be647@oss.qu=
alcomm.com
Cc: stable@vger.kernel.org
Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 38 ++++--------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qc=
om-geni.c
index ed6495e..3a3c871 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -82,9 +82,6 @@ enum geni_i2c_err_code {
 #define XFER_TIMEOUT=09=09HZ
 #define RST_TIMEOUT=09=09HZ
=20
-#define GENI_SE_CLK_32MHZ=09(32 * HZ_PER_MHZ)
-#define GENI_SE_CLK_19P2MHZ=0919200000UL
-
 struct geni_i2c_desc {
 =09bool no_dma_support;
 =09unsigned int tx_fifo_depth;
@@ -130,7 +127,6 @@ struct geni_i2c_dev {
 =09spinlock_t lock;
 =09u32 clk_freq_out;
 =09const struct geni_i2c_clk_fld *clk_fld;
-=09u32 clk_idx;
 =09void *dma_buf;
 =09size_t xfer_len;
 =09dma_addr_t dma_addr;
@@ -201,44 +197,19 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map=
_32mhz[] =3D {
 static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 =09const struct geni_i2c_clk_fld *itr;
-=09unsigned long res_freq;
=20
-=09/*
-=09 * Frequency counter tables are calibrated for a specific source
-=09 * clock frequency and are not valid for any multiple of it
-=09 * (e.g. 64 MHz, 128 MHz).
-=09 * Use exact=3Dtrue and verify res_freq matches req_freq literally
-=09 * to reject harmonics: a 64 MHz clock that divides evenly to
-=09 * 32 MHz would pass exact matching but produce double the intended
-=09 * I2C frequency with these counter values.
-=09 */
-=09if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_32MHZ,
-=09=09=09=09    &gi2c->clk_idx, &res_freq, true) &&
-=09    res_freq =3D=3D GENI_SE_CLK_32MHZ) {
+=09if (clk_get_rate(gi2c->se.clk) =3D=3D 32 * HZ_PER_MHZ)
 =09=09itr =3D geni_i2c_clk_map_32mhz;
-=09} else if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_19P2MHZ,
-=09=09=09=09=09   &gi2c->clk_idx, &res_freq, true) &&
-=09=09   res_freq =3D=3D GENI_SE_CLK_19P2MHZ) {
+=09else
 =09=09itr =3D geni_i2c_clk_map_19p2mhz;
-=09} else {
-=09=09dev_err(gi2c->se.dev,
-=09=09=09"Unsupported SE source clock: must be exactly 32 MHz or 19.2 MHz\=
n");
-=09=09return -EINVAL;
-=09}
=20
 =09while (itr->clk_freq_out !=3D 0) {
 =09=09if (itr->clk_freq_out =3D=3D gi2c->clk_freq_out) {
 =09=09=09gi2c->clk_fld =3D itr;
-=09=09=09dev_dbg(gi2c->se.dev,
-=09=09=09=09"I2C clk selected: freq: %u Hz, clk_idx: %u\n",
-=09=09=09=09gi2c->clk_freq_out, gi2c->clk_idx);
 =09=09=09return 0;
 =09=09}
 =09=09itr++;
 =09}
-
-=09dev_err(gi2c->se.dev, "Unsupported I2C output frequency %u Hz\n", gi2c-=
>clk_freq_out);
-
 =09return -EINVAL;
 }
=20
@@ -248,7 +219,7 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsig=
ned long freq)
 =09const struct geni_i2c_clk_fld *itr =3D gi2c->clk_fld;
 =09u32 val;
=20
-=09writel_relaxed(gi2c->clk_idx, gi2c->se.base + SE_GENI_CLK_SEL);
+=09writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
=20
 =09val =3D (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
 =09writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
@@ -1141,7 +1112,8 @@ static int geni_i2c_resources_init(struct geni_se *se=
)
=20
 =09ret =3D geni_i2c_clk_map_idx(gi2c);
 =09if (ret)
-=09=09return ret;
+=09=09return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz=
\n",
+=09=09=09=09     gi2c->clk_freq_out);
=20
 =09return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
 =09=09=09=09  Bps_to_icc(gi2c->clk_freq_out));

