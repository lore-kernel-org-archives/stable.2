Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575085;
	b=q95mkUkGwLL3fiSzu9e0RfEynyWPRC6oqwHNi6XOvEToqPbToQLWV4bfBsJO/79vCadK
	 SkmibUDh0bpERuw/aY+CDLmFvEYBCoqq+dllj4rP/7AHuipTv3wGB1aU7LgMgeOtZ07n/
	 HgUtiY+F9yQfH1Hud/uBkZvweA3ObFT6owcSvPo1nLgHj41LFBNeBl5s5FB59slfkMCcA
	 E08XBMPLPHNSDJXpXlQt2StNjbtRT2gOZdO38J8TwV/LZypSagBc1aiVirtrZn0PlDau0
	 EC+gKjw9SKrFqf8JaNNvumsmxGCk8RZaX4qCGmbwhjAu4i4j4T5trpnGjbWO6CT2Eyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575085;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=iTH5aDa/sBYBNW7W5yb9FXNPOE3jaqd9zaGvgmhdaMY=;
	b=okeRVzb+DOqHN37T44EF9IQhEal9kAspgLmhuxIfV2TP08GPcYRmhiHDlUt0WGkvGM2h
	 7SeuHsYXtX70KzHChvxkfx8rz9dS0sGwiQiYlUGGVoTmHwPT9rJYhSB27Xb+p24s57MZv
	 an269S7ZrJFB2FOfNfZi4G8lxZMdEZQKM07O6ya5aSFSN6+4bPKd6CTcOy+qQCWTYbEHu
	 zKdLVH7sErO0Kt/WaQx6Fzr0R0SCd0pctI32mgdTGaIxbw+WVXARRC7xPHOx4MTxp1gLJ
	 LY6MkPgvJHfrPEKxTbgMTyp5sOTTL6l+Z1qItQMPSiA2widX2Dl/BeJbLXuYmRyzDYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=QI37VH2l;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B0606A32D;
	Fri, 13 Nov 2026 13:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 110B0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=QI37VH2l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=iTH5aDa/sBYBNW7W5yb9FXNPOE3jaqd9zaGvgmhdaMY=; b=QI37VH2la/rOalBsa84on14Rlt
	KfKyp/nfSnQw+WUcxTndB1RmlWnGNOxqZyZbwxPwsHt56vCnuhUqrlJMLk2DV1SegPO9r6RMN2Qxs
	63NC34irpRtaWb9MVbxeSL9yJurEzKODaHFch3/OA2Y1oOtgjyBd/tlw0+fyED9bCYpGMBL4KOimb
	draNV9sBhHw009ZIhpwNPrF5BX11WY2noL2UNbCDivczKjXZmU31KmNDx+WiAalteVPdkcxGYuNAq
	swsvBPf+Pl0ohgOulQR2qQ/AA9r3HNVgXU4CKu6riAjUDCYN1OnNTvCJsYtSoGJBUIA4kLTyvzaab
	rOBZOdeg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRqxL-00Ell5-1w;
	Fri, 13 Nov 2026 13:04:39 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Nov 2026 04:49:14 -0800
Subject: [PATCH v3 1/2] x86/mce: Restore rate limit on MCE logged message
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-mci_ratelimit-v3-1-ada38c5a6c88@debian.org>
References: <20261113-mci_ratelimit-v3-0-ada38c5a6c88@debian.org>
In-Reply-To: <20261113-mci_ratelimit-v3-0-ada38c5a6c88@debian.org>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Qiuxu Zhuo <qzhuo@nvidia.com>, 
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rik van Riel <riel@surriel.com>, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; i=leitao@debian.org;
 h=from:subject:message-id; bh=SSNhLTEFQKWY7woUFhxxhLSjyLI5IV0buGB7ZfIAUdo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9wrdlRg663z8pZ6fQ81HrT7rrYgEfxGWUR/y2
 Rut9VWb+fCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavcK3QAKCRA1o5Of/Hh3
 bUu7D/wI7EUCQ1Zu879WmMjWvnED8D1le1zSX0/8o7bjpqlRYfKDD4UP2rEE6IwXVaAlankyvhj
 71XrWfWHGj1XVrgIhRMZMRgaljSYDAE/tBpXqoGAPqPGFlswZBi1iBJB5fA5QoC2iRoQRA9zHQj
 n6A7KDSz/hnqqtfy25BGmExpCeHYmq2J03yELMqfkKVTQO/rLtWDnwWWtid3LBAlW6AhcaKymvS
 qDi67ocWqObwV3VAzYcSok3o4kMSNalyaZOEFlPf/woY2cFqWWA5Hcg1J6v1mRqtXocpMZF80sP
 Zljt2InGaivCF52k182S53Cw9zK22YUik0nd1G+s1NrKeked5G9ZM5ivBXKZOh2TfusJpX43v2X
 xFz4GA+IEcoihhgGefyOBHG35nFGzmrhAJt4ZUVTtCo3JWMvq52ncQbXX3aRtFbqCiAd9Q3mdRh
 0cUOEgWIVBUdhNt3PApCwi5cN75qOQvvbmvC1kO5slTLvmzx4SmFqdBZKlgybCvsyV5sgMjwfV3
 8Msm29IIONpNfkPck2iFiqqiP/aY6phvBQdqAuhZVcN7UhJsXjG/X8G/6V3EjYEVMGkcCoBw7Fl
 CNoDMTSUiT+vEwy714YKJFx3Fx42/DrBwAfZcOsUI251VghOG9o5KhdnTs6TpbeSNj7DnQ4Dlu9
 Wl9EXhk6Xzh4/Rg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

From: Rik van Riel <riel@surriel.com>

Commit ea324444ece9f ("x86/mce: Restore MCA polling interval halving")
moved the "Machine check events logged" print from mce_notify_irq()
into mce_log() and dropped its two-per-minute rate limit as a side
effect.

A particularly unhappy system can spew out around 100 million
of those "Machine check events logged" messages every hour,
without that rate limit. A large fleet may have several unhappy
systems, leaving the netcons infrastructure somewhat flustered.

Reinstate the rate limit we had before.

Fixes: ea324444ece9f ("x86/mce: Restore MCA polling interval halving")
Cc: stable@vger.kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Qiuxu Zhuo <qzhuo@nvidia.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/cpu/mce/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 50b1614968be6a..06f858faf2b1cd 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -150,8 +150,12 @@ EXPORT_PER_CPU_SYMBOL_GPL(injectm);
 
 void mce_log(struct mce_hw_err *err)
 {
+	/* Not more than two messages every minute */
+	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
+
 	if (mce_gen_pool_add(err)) {
-		pr_info(HW_ERR "Machine check events logged\n");
+		if (__ratelimit(&ratelimit))
+			pr_info(HW_ERR "Machine check events logged\n");
 		irq_work_queue(&mce_irq_work);
 	}
 }

-- 
2.53.1-Meta

