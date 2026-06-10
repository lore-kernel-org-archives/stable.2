Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709238E8D5;
	Wed, 10 Jun 2026 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079023; cv=none; b=ei70NOHIu3bdduvKwBOp//jpNhNBbnjcmWF1bogYAVtqF6e6AS3sM5CtftQDgq36NVZcBWYSkLqpJY9Ngn12bffFoWE8nJhNjq03TFXcA2MiMIhn1vcuADVITqQHvwujItxAVGOxHy3PDF+e8LzgtrK2ihliKujsiYW3rju6kgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079023; c=relaxed/simple;
	bh=XgRaR7RscjELrgEdoW7HIc4P4cxDZHxqOO9V0bqMw3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VuNYqbw9yzQekRyAEYaMg6mhUhdLyYaKKSEwprBdY3Wvjm6KKhgN13QNqFP9ODGYHRUUl8Z1l8G4Lg5M9tTc5M/7YytIiaU30oBp9AWvbMJP+P5SmthRc+cksVeG24SrogeY3/whFvVYCN3pvrjiuEODrkEToXxs5PWspqeFDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from ajratkogda.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id 5417423374;
	Wed, 10 Jun 2026 11:10:20 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org
Subject: [stable request] mt7921e: backport two mt76 fixes to 6.12.y
Date: Wed, 10 Jun 2026 11:09:43 +0300
Message-ID: <20260610080943.17734-1-rauty@altlinux.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider backporting the following two upstream commits to the
6.12.y stable tree. Both are in Linus' tree and both cherry-pick cleanly
onto 6.12.y:

  2425dc7beaadc ("wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain")
  5ed54896b6bd4 ("wifi: mt76: mt7921: fix a potential scan no APs")

Together they fix a hard-to-reproduce MT7921e (MT7921 PCIe) lockup we have
been tracking on ALT Linux: after a disconnect (signal loss / AP deauth) or
repeated reconnects the chip ends up in a wrong firmware state and stops
scanning/associating to any network, recoverable only by a chip reset or a
module reload. The symptom is reproducible on 6.12.y and gone on 7.1. We
could not bisect the symptom to a single upstream commit, but these two are
the relevant fixes on the mt7921e path:

  - 5ed54896b6bd4 aborts the granted ROC channel before station removal, so
    the firmware is not left in a wrong state that makes subsequent scans
    return no APs.

  - 2425dc7beaadc stops a connected AP's country IE from re-triggering
    regulatory/CLC reprogramming once the user has already set a regdomain,
    which we observed leaving the firmware power/regulatory tables in a bad
    state.

Neither commit carries a Cc: stable tag, which is why they were not picked
up automatically.

Both have been tested on real MT7921e hardware (Acer Aspire 5 A517-52,
ASUS VivoBook S14, Lenovo IdeaPad Slim 5 14AHP9) running the 6.12 kernel.

BugLink: https://bugzilla.altlinux.org/54853

Thanks,
Ajrat Makhmutov
