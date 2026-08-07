Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC1395AFA;
	Fri,  7 Aug 2026 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100888; cv=none; b=OdtYybF+8THVBj8c4/ahTgJyhXmSCkNn1snFXiWU8+q9eh1eRAW76o1+UGXkr8jqHRDLB45MyqkWSUlMwfaxO6qp5Vcniw3iuFIhMmt11n0z+IUfazkowAqLrj8kxQLo1eOgQIrY2WiDZNYZ5Adc787wGq75UguXd5KDzMRrP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100888; c=relaxed/simple;
	bh=M0M5lKX2UIIlsM00QGrNbOWcO4tieupUNj/BRRfnFSw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A8BWENsPYhV5jM0cnStnSNkSgBCA9AjMiBnxPhhTg/GV98SJ/flLspQVBF3Mr2BLiJACq6WTd0s0dDMX+DPiHIzVqyrkd9Hrw9wZTwQl5OHyne1mZWTh72HeP2qRY1odDqWCXuzZffGeHPOjdJ9pawtjbBClZLiuuwPDzRKjXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ak/VtaGN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ak/VtaGN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 516EF1A1499;
	Fri,  7 Aug 2026 11:08:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 161EF603F0;
	Fri,  7 Aug 2026 11:08:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 121A011C3763E;
	Fri,  7 Aug 2026 13:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786100876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=yNytByz0M8PfLXQYcgJklx2YJsYQNq7iZSlShAEm+9g=;
	b=ak/VtaGNbw6Hmk6BAOzvmkq4mNViNVJDFBwvhCPKYJVaxoxIMASHWM1BZFKWfFsA36hbFM
	1P+LJKRt0o6C4v9jfKMSudxCqL8bjZeB+6VplvT9lVUMPyeAgyz/HbSPp48SZZR+k9uiCY
	fX1BfmzA3sGWNM8+ebsH9ltRpJYl2SruaWma+ojnfiMRZuD2SCiq2wElahQi6vSrmQUKkX
	KboM/xKA1Dk+lK5PfGYhhayC3LrW6btTbt+/Hfy3dCJVw6wso2kfPFVFQmK/mgSOs5EgTs
	3ymfiLgUzg0sVqzDRNaWe0KVTRo/C3xX/SoYfcrtVhkTbrK/qKLOdRvynwasTg==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Subject: [PATCH v3 0/4] mmc: sdhci_am654: Fix DDR50 mode for cards without
 tuning support
Date: Fri, 07 Aug 2026 13:06:56 +0200
Message-Id: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNTQ7CIBgFr9KwFkP5K3XlPYwLoJ8WY4uBSjRN7
 y7UGNPlJG/mzShCcBDRoZpRgOSi82MGtquQ7fV4Bey6zIgSKklDFdaDFBzHrrcOK0Fa3nGhjAa
 UjUeAi3uttdP5y/FpbmCnkiiL3sXJh/d6l+qy+5XbTTnVmOBGSFUTBdy0+mi8n+5u3Fs/oNJO9
 G8rwrY2zbYWAMKAkjVjW3tZlg+u72sy+AAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=M0M5lKX2UIIlsM00QGrNbOWcO4tieupUNj/BRRfnFSw=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqdbyGI24z46x60j3L4aDDWbXgtncz2EyIo85PM
 Dm5/1Ph/ieJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanW8hgAKCRAGvnxbVl7J
 RWacEACTq64gfSu4iWyG4NWbgPUi5m07R9HZhwNQt61k+MTHmRECGKocPVGSZTVbTz8hKjzqSXO
 h0rlZiDKg38lW968cbuQvUOk3idGPdwOlHOg8d6JytV7JK9r4UeCHM+hCjCc0seFOfO6hvN2tvR
 VfqX1JdyqLrvM8tiCwz9gpOaHoH/WPSUzPSCblMQ7tZppe+uWasY8cYaKizkbFVpB8nW3Hna5rg
 Tltj21eTrgzmfBlabQW371Q9ethVXJvCR3d+V61mI09SpcZxCokBNAGJ9TAY9sVmRvKsRS1di1S
 qujozxhQstOAoOTnzrVQMtz5qPJDxGSXu1tnABqpVuBdlfV9anf2IWOEpbDyfk/9WhGQtLW+pJy
 jeFvcCesxdRbsV26Rp/x3XL8EXIqjuOUKb6M442MRnfGPzZ/bs6255sxlWq/wmw1XDt061+Oc9/
 NoqpEJr75hF2rtONyhfRU8Va3/MQR13kZwDLy6zHmDZZoBMnucgdJpY8LcBE064V/vwAl3P/3pm
 YL4keFxjrl5XIhCPdJMRqSz4RJT/+qnR1CV1jv3Tn+PYCOg15mp3KCwxRKxcdTYn4Kc+2LCrUFU
 6tAm6tacwJjfTkHGj9felesgkfyCjkzWTnhtCYgRkhEatxsGVYAUw2GPpEu8Lpe1Nc2w+XsqYRn
 fM06P7bUIOAdokA==
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
Changes in v3:
- Collect R-b from Judith and A-b from Adrian
- Add debug print when applying DT fallback values (Patch 4)
- Link to v2: https://patch.msgid.link/20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com

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

 drivers/mmc/host/sdhci_am654.c | 43 +++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)
---
base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
change-id: 20260728-am654-sdhci-85094d458bae

Best regards,
--  
Diogo Ivo <diogo.ivo@bootlin.com>

