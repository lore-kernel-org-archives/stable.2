Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A563502A5;
	Mon,  3 Aug 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764922; cv=none; b=WfGYu+SycxQ7KiGc9w7tjiWpUjfcIfljs2DkjnrqCaBuz3kVq0Mle+m2jPjo8IuGDv18lBPdnch3w7lK4+YPG53Bed9uh4bm6kjhm272ECAgxuGhSuNvpWVPnHak5jMS0dFNOtqxfPOeIVj4hr/EHnYlWp8kQBGtZzD+mMe/iZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764922; c=relaxed/simple;
	bh=GzLV3Uc+5w28VAcTIzCHxdnNuTOTNbN31Lx8R2QgpAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y82FxPMRg00m21AO2Fzzx6CBps6s8B+aDBkIVIM039MNa4amcKuBAZquBsrLmhovmFEuBkojkeKDNxB1roPvVmbzFb/vHYzQJHfBO0Tjf8Da7s7rwlge3K4haQqct7IUwqih5AZByQcFCJu81S8RSOdBD4Q4wpjLtIE7OLn43WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aXGt/PO2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aXGt/PO2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9521F1A13D2;
	Mon,  3 Aug 2026 13:48:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 684216029B;
	Mon,  3 Aug 2026 13:48:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F31711C30CEB;
	Mon,  3 Aug 2026 15:48:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785764910; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/+DsmGd9kahA+v8FP72hTxMpgTQQBsFpc1AqdkO89sI=;
	b=aXGt/PO2vTKkgolUymTtqTlulAQooiQkUVPbnRi/zc3yGRER07GWsLZSbMjmlFlZyxZA/o
	jDAq5hr9l5OKeNvOPfyiKu12IdcAUvVnjmPul/S1I2KgyBVX+AtNqr04K3ksME7NMaYwcN
	5pKWLAeb1YDlJxmeOn+Hpvg/hRrNux8IRW+AjRFsftThRz8r/B6iTfIpSXize52X4m89aE
	nxKJ/sbIM030bCdfk3HR/JbN5lCSmLTx//2Bs4COej9rRLDwFWeC1C3ZeeyzIIGxAKFqxQ
	d9sN6EloZOsUK80HWGQ7RrH8s5/2D2R868mnHmP2jlhgvIs+ICQgs/1rxGQ+hA==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Subject: [PATCH v2 0/4] mmc: sdhci_am654: Fix DDR50 mode for cards without
 tuning support
Date: Mon, 03 Aug 2026 15:47:30 +0200
Message-Id: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw6CMBBFf4XM2prStFBc+R+GRR+jjBFKWiQa0
 n8XMC5cnuTccxdIGAkTnIoFIs6UKAwriEMBrjPDDRn5lUFwUfFaaGb6SkmWfOeIacUb6aXS1iC
 sizHilV577dJ+OT3tHd20JTajozSF+N7v5nLzfuXmrzyXjLNaVbrkGqVtzNmGMD1oOLrQQ5tz/
 gCH454TugAAAA==
X-Change-ID: 20260728-am654-sdhci-85094d458bae
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
 Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pascal EBERHARD <pascal.eberhard@se.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2185; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=GzLV3Uc+5w28VAcTIzCHxdnNuTOTNbN31Lx8R2QgpAY=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqcJwrip6/Ux5uCsRgRfh+5q91psZOTzMefCdpG
 YvUAsJeHoOJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanCcKwAKCRAGvnxbVl7J
 RfYlD/9mut7F51qC/DfXrrSPOO6lnkpG1a7E4hJqJ/T8C00AI4WIqigAyCJ9h2f4FjwShvt2fZ3
 jyItBlfV8zdvYll5ET9n2+qOK7I9GRPi7bA806a6KX2uJIDvGQAmj5dco8U0ViUYRLxjTWroT7Q
 DViPjSCGwsZLm9Es41IW1LBWY+TkpAlc27z9KeJDVsTngHsztO4D4feHxeE9zpj1enrkLgGf5Lf
 MEE/524DRn1fK+YtsljHGH8DXs/bVVmW7BleN/v5Z1U0PUWwX2DKGJLglql/noiBhH0ERyChBiV
 nVtmm0vDzn9SOhilm9edvQvPU25zxQBTJcux+eyLVCTWZkQH+lh9TAYEmFqrMcJlJL0osyaSlc6
 WKgsdndpXlZAZgbVqNoh09cCCte2qcw6TS6BRljhI3jvWrHQSmqctttcN7G1KcmRekgeVUhV1Yi
 5duN9M3P0M/TghePtlUegQsA6Hc8S5kSRvuTaiuJT3fsr9Uvg8EYADs9qbLluuDOhnqLWToWzVV
 zw5Of9eLDfTjWrwZ1As6bYJgMOq61u+rAvDq3bKUcqcagmqfvRLJXWDjxviTfS2hF6fVOnZl5IB
 /7iyIyaGBZwDVaN2gE9o7uxzk4QamPgJdJjtiXjhIDJPWzIc2YEx0O3AhWGVSy93NeYBwnIuyoz
 /wPM5PsLn6seXhQ==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

DDR50 mode is not required to support the tuning command CMD19 by the
eMMC/SD specification, meaning that calibration may fail on cards that
do not implement it. This series fixes four issues discovered when
using such cards:

  - Patch 1 moves the tuning_loop counter from a persistent struct field
    to a local variable, preventing failed tuning attempts from depleting
    the retry budget across calls.

  - Patch 2 ensures the command/data line reset is always performed
    after tuning, even on failure, preventing stale data in the
    controller buffer.

  - Patch 3 clears the ITAPDLY enable and delay values on tuning
    failure so that leftover calibration values do not interfere with
    subsequent I/O.

  - Patch 4 falls back to the DT-provided itap delay value for DDR50
    when tuning fails in this mode, making a best-effort attempt at a
    known-good delay being programmed.

Together these changes make DDR50 functional on TI J721E SoCs with
cards that lack CMD19 tuning support. This second version addresses
all comments from Sashiko, which I found to be correct.

Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
Changes in v2:
- Add new patch moving tuning_loop to a local variable (Patch 1)
- Clear ITAPDLY array values alongside HW registers on tuning failure (Patch 3)
- Save DT-provided itap delay values for DDR50 in dedicated variables
  to preserve them across tuning cycles (Patch 4)
- Link to v1: https://patch.msgid.link/20260729-am654-sdhci-v1-0-7568108e4b9a@bootlin.com

---
Diogo Ivo (Schneider Electric) (4):
      mmc: sdhci_am654: Move tuning_loop to local variable
      mmc: sdhci_am654: Reset command and data lines on failed tuning
      mmc: sdhci_am654: Clear ITAPDLY on tuning failure
      mmc: sdhci_am654: Fallback to DT-provided itap delay on DDR50 tuning failure

 drivers/mmc/host/sdhci_am654.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)
---
base-commit: f932188d6b0b684ee8555c8ecf1cac3567c4b106
change-id: 20260728-am654-sdhci-85094d458bae

Best regards,
--  
Diogo Ivo <diogo.ivo@bootlin.com>

