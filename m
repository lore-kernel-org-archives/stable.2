Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E23783BE
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201210; cv=none; b=aPK/TGdkbYVWqfldWKZKpCC4a0Sfp8XqpZdHyUnpnF8uKamn388FoCsl7s+UA29/g1OV9JTwXwYZgeVXTNdE+x4kpZC5enS0pc3TXaKyYiV/jwnBeTvLIL6hoAmREm2Ouu8RS0TuUDE9ETLVS2EPtmWsJpM6y99AsLdGipKsr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201210; c=relaxed/simple;
	bh=B5NcsJqiM6ca6zoKCCSiRnmiGiK51EUO/f+42QeBqzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5CMk0aMz3+nyfeZJt1qTG2cJ35SuP3yBF7LUCS7QDfccQ7cPPkdS0VPZ2rEU8aLzODYqHUTznrx4t0TOIh+RuaLhLVqPu18OcznZx5swgLVxdmrB0ZDKERQik+BaHKfw8bPGbi8OSMHrwemRuAvHrMwzQqrXKO4ZEzPCO8BfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBqIxRNB; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBqIxRNB"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35f1f76ea84so760316eec.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201208; x=1792806008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cket7DPZv1j5YnyOIveBa4NpPNYaScJjvnuFzxjWh88=;
        b=WBqIxRNBUqBRRhN6b7EfvbJPWt6hwGRIlRYS9Qf57HMtBDdB7YOqqF7LSkXOZ272cb
         Y4Ur9MaxHuCDIjGl95MejJfqlwhOH6DNbNrSiFW/lUQsqW3kQHjIc4AsYUvIAEdR1Kv6
         qs5o7XJqW2gv1rCEhbo60Nu0/+UPO97Qf3FRErUP3VUBx5Xekknkn7tBOhOhlWCF+fj1
         pED7QO7Udl2PBu3HbMtqK7r9IP8ltoc3bnQurCc6LAWdJQYHS/MGaj//5XJVX4umkEcc
         /8iV9933xXySzoTwS9m56dFDaLVXiuGVPillMcKWuJ2FhdQxSahzVd0ixF9YHMyQ+ok7
         csOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201208; x=1792806008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cket7DPZv1j5YnyOIveBa4NpPNYaScJjvnuFzxjWh88=;
        b=kG/o4fXLZQ+WZ4YzJBo+YgnBxuznSLrPMFek7IP41SZE51sd+ku3PY4nrmP6XXf2lW
         NQ30i1e9ijSM1Q4vLElFWn//ncOawL068IGZwRWQHVfscNE7Fs6AyIE9+JGqtCyFPNC1
         xhVMGYKmmRUYUjKIXGP2EqgQXAfcLsq0cvd9w2iqLj55HviujNG6jMf7iaoeulWxC4T8
         cu1FqvSgMRgSs6v3jPR5cXIRY1o7Xb6TcbveDDJ5xvmzTjmg7doR+wy6bOUkOCv3aImP
         +eTxeVnz7l3r4255jRA+bp1tIZw1eZEggpaQL/q2NNasd9pgKAnhiY2DhFqaQRUWIt3I
         pAEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqC38QQ7YuIeyWAKI/uehSJOzeZm7n5kJmoxfMTlOe7xqF5NB3REk9HjgmDy3+qsh3z53umr0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHluvWW1hbJFrkQuqtKrgo50gaWAmmRRPh9d0dhe4UMIUwiFfL
	yI1jeXUVHijVPyZVeYSNstHtvx6Jodg8IoiqczICcYg9AUXgZS7cUrc0
X-Gm-Gg: AYBFou3yJzfgLPBCvdQnpEKIWhdnHg18f8CHi4a+QsJ4jRRu3tqbfUN9XdhihJ92Z47
	9KLyB98HCGdeAwQCWz9Dd//PKoYE+pKau69GmNc9p3CKY0WXp+mRcUSHRe//LkPlTkucEKrp4lN
	NnADf7efVl7EcbIVyZr4Mw2vvQLWvBzlnodg3QrZT5VCk95Nt+qf571diksa+ae498WZCMYo1c5
	sSOcLj/3xBSYtahL9k/DFxOeYrKtbUCLVy2MHUqyQluZWr3RiWKM1zsVgisHzVwBQ1GV6x+r9D5
	x3PlTfTkna495fIrc0lKHi9CfQjF7ses0K1CimKzvjYmpU/DDrNBdpaLwrVhQ6kT3Nt5ERGL8vX
	rlRCBW/RSniYYbXvoITO0vBLzcXYfHUzxwGRV6WqNsEV9V/ndtqyjcCtrwnfjvNQ91gIkwnTB9/
	z2Tnzl7SmOWLXjjNsAdmy/QUDVmD1+gNRUA7XLcfFVz2uUvcX63RjWDTFwbEbgCygloyYhS2BPF
	ZGcylAthpoFKKCJ5iSJroIkRN8ujp/fYZoiIvc6ZjBa6lk9QSn6+69LY59sG3geKwLUkppU35A=
X-Received: by 2002:a05:701a:c951:b0:156:3684:96db with SMTP id a92af1059eb24-18515e402d1mr2235374c88.45.1792201208381;
        Fri, 16 Oct 2026 18:40:08 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:07 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 01/11] HID: hid-lenovo-go-s: Return ret instead of 0 in mcu_property_out()
Date: Fri, 16 Oct 2026 18:39:46 -0700
Message-ID: <20261017013956.2440130-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mcu_property_out() blanket returns 0, discarding the ret
value and any errors with it. Wait completion returns a positive value
when it is not timed out, which would error on all successes, so if it
is positive return the ret value from the raw event handler. Only if
it is 0 set it to -EBUSY, otherwise pass the actual error.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index a72f7f748cb5..68301d4c762a 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -38,6 +38,7 @@ static struct hid_gos_cfg {
 	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	int cmd_status;
 	u8 gp_auto_sleep_time;
 	u8 gp_dpad_mode;
 	u8 gp_mode;
@@ -435,7 +436,9 @@ static int hid_gos_raw_event(struct hid_device *hdev, struct hid_report *report,
 	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
 		GO_S_PACKET_SIZE, data);
 
+	drvdata.cmd_status = ret;
 	complete(&drvdata.send_cmd_complete);
+
 	return ret;
 }
 
@@ -474,12 +477,10 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 	timeout = (command == GET_PL_TEST) ? 200 : 5;
 	ret = wait_for_completion_interruptible_timeout(&drvdata.send_cmd_complete,
 							msecs_to_jiffies(timeout));
-
-	if (ret == 0) /* timeout occurred */
-		ret = -EBUSY;
+	ret = ret > 0 ? drvdata.cmd_status : ret ?: -EBUSY;
 
 	reinit_completion(&drvdata.send_cmd_complete);
-	return 0;
+	return ret;
 }
 
 static ssize_t gamepad_property_store(struct device *dev,
-- 
2.55.0

