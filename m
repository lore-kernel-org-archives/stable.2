Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339229;
	b=NGjpibyaquzjY1aOd2yGCQn5MEAvO1HT3whcbBQxt0Mp7cGs3pwWP8hhMQ1cuMa2GIWs
	 sz0E3mqDo54/L+yMg7EAKtohcdud7DAqcdOk6N7qDh+1UoEGE/ty5WjovuOMad1RT0rsJ
	 Ble671IOAa+GyOBgj1Lurwvuzex3voU+mQRY6bOg72xnjxeI5XP2gxHYgrEAwxJaVAJIn
	 vp+kaDhza6K8z2sbADh5XyjedFobvzzvtRv6GJIu28xaHBF82KRdfJ7cwgkeHmCQW7hPX
	 krpyQv0htAgkWUeaeKYogub76fYxNXQw5qcMf1x5JzikMwB803+UbSZe3GUPE+e9Adg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/bQ8adyPVMPdO9KK3GwBJwHZV1j//sUqB8zwXdbPHB8=;
	b=TggLZdJvU669LQLv2ilbBn/3b+aMloztv846J0YdiLbAHaMR4rNFYO7Dler3UbRbelmF
	 eEYaIcVgp0rgScMcL5WOOsIRzLTwvHJgeGTOMDb1enpPhT+TuY8jwdzMoy7fx52mPUVby
	 QrGzDE0i+h4ozI3Ye8Ojm3dvgCm+K8sxvu0MtVBEK0UjnQUvKqH8HlEpIRTi4BNTVJHXH
	 wrAf//VwCuSJZn6hSEvYnLOBMxrvnxV0Ojb71YgFK5PeN15B9MwZk6jrMXEMNvbaCX1la
	 HK3rhQlVhCFrjGFDdNHkWMHP/nVyfzLUKx25KaIWcoaJwOAPG1FVAzTTTncKnu1oqAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3++27Wr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3++27Wr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6631F0089F;
	Tue, 10 Nov 2026 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339228;
	bh=/bQ8adyPVMPdO9KK3GwBJwHZV1j//sUqB8zwXdbPHB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3++27Wr4LkdkR4nASDiilF64BZMe6wp9ugFcNyMpr+dDst10zY2yKTcj/VFjREAz
	 Ndci3HoH6t/oEV+IpfWUjVceeBJYSPF/hiRCIEEyBAzAuTMOLeNhn5BMkdHAsOFtXz
	 dPAu5K38om2/dT/0PBLvy2Wn77UNMIptghaUAxTzfle5Mv3OARRnpTl54fXcZUh1P7
	 fHaun2exBZzQMgc2BmQEpezoYAXzIBPFTbtKYI+P9cbf/DZCOYiXmFbyOneaculSF2
	 0sHUZ9kdl2V1FWnpHlZAG4REBrpHPuF3MYdEWzUj6GBXIhcFdCB3LHAw4GHGljW2LP
	 FEb5lZ3NVDw4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Carella Chen <carella.chen@infineon.com>,
	Jason Huang <jason.huang2@infineon.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] wifi: brcmfmac: detect firmware FBT and OKC support
Date: Tue, 10 Nov 2026 14:33:44 -0500
Message-ID: <20261110193151.3473712-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051913-failed-6.12-6fff9de5c5b4@kernel.org>
References: <20261107051913-failed-6.12-6fff9de5c5b4@kernel.org>
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

From: Carella Chen <carella.chen@infineon.com>

[ Upstream commit b1590c5eef0fadb5bc33689f9d98ce58b91154e7 ]

Some firmware advertises Fast BSS Transition and Opportunistic Key
Caching support through the firmware capability string. Track those
capabilities so later roaming offload handling can be enabled only
when firmware reports support.

Assisted-by: GitHub-Copilot-CLI:gpt-5.5
Signed-off-by: Carella Chen <carella.chen@infineon.com>
Signed-off-by: Jason Huang <jason.huang2@infineon.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260911065656.1269623-3-Jason.Huang2@infineon.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

The existing feature table predates external SAE authentication support.
Add the FBT and OKC entries without introducing the unrelated SAE_EXT
feature, and preserve the existing SAE capability matching.

Stable-dep-of: 6fff9de5c5b4 ("wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c | 2 ++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 0d9ae197fa1ec..461f52a069386 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -44,6 +44,8 @@ static const struct brcmf_feat_fwcap brcmf_fwcap_map[] = {
 	{ BRCMF_FEAT_DOT11H, "802.11h" },
 	{ BRCMF_FEAT_SAE, "sae" },
 	{ BRCMF_FEAT_FWAUTH, "idauth" },
+	{ BRCMF_FEAT_FBT, "fbt " },
+	{ BRCMF_FEAT_OKC, "okc" },
 };
 
 #ifdef DEBUG
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
index 7f4f0b3e4a7b4..98953250efe83 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
@@ -57,7 +57,9 @@
 	BRCMF_FEAT_DEF(DUMP_OBSS) \
 	BRCMF_FEAT_DEF(SCAN_V2) \
 	BRCMF_FEAT_DEF(PMKID_V2) \
-	BRCMF_FEAT_DEF(PMKID_V3)
+	BRCMF_FEAT_DEF(PMKID_V3) \
+	BRCMF_FEAT_DEF(FBT) \
+	BRCMF_FEAT_DEF(OKC)
 
 /*
  * Quirks:
-- 
2.53.0

