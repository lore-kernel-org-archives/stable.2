Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16B47A87B
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452396; cv=none; b=dcoP/o4qFDo5SwYNYd24OBSSXntNrozC0Woike+32y423kiluSdtXUt58U0ocT3t2aNnjmjf4TbGgRyS7tNE3e7Wr+IvhkpLWIZ+Qf+3iaXODq6noOhBWFmpQ7ivzkd4d4TV0b+Tx+hxWzdP+ohXe3/EocqhaMaCmbrLIPCakWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452396; c=relaxed/simple;
	bh=OONOT/u2RF+QM/IK2ViI415NAzwW1HqZQi0cyFe9ITI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcDhjGeE9Xc71cROgKl0BWPWjVRQHYAZ1ZtbfVSI/qTzMSKVLFEbpESPYFWt6NeiJB7o+KGvJFOZlyNje3EsANAYAzER72OPlHTbP6AEssnjICz7jkq0fR5P3u4mM0KPhm4Ji6OC7yvwgIgfpcoVvflcZwepgiyojkg9n13T6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmQYBdRV; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmQYBdRV"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3515f9a5d25so4070462eec.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452395; x=1792057195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4rFc6GguzolXlzKjIBhEDs7LDWxbG/Idzt5qHBXUNks=;
        b=gmQYBdRVeTNlTKN8VFXt08tujOvk395mlBYSrfmZM4i1/DZf5WN7uNkKNa3DL1gVR6
         q4x3QEV1RW2fAY2nniq03UeVNU08CIlQWHspT3Lrt4Ix1ByS3C8KIPrOqfjq6f0aBRHD
         6rSm3NpZzpjW/4/DP0W4F9BeDHHdaqZzOqWQfi8ihc4djIgN4DumvYtVujLnLL4EEVtq
         7NDqnNpMFRhgepd2UcVdyHnr1dP/4A+9OtNtB58dHzE3dafsnqd2TP+v5Nt9xBtnf04v
         qhPgZ6yK24QhDlDeqMo51+eMxkkt+pRmoR1P1hgPTpXzjc0Vj1hhUdmEv+tzJhrynUzK
         WynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452395; x=1792057195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rFc6GguzolXlzKjIBhEDs7LDWxbG/Idzt5qHBXUNks=;
        b=hattoQsKaRexD2jDJ/UDxYw/h6VWec8JkcJJMBVK83D/JpJlaSZP86bhddBNit3PnT
         Dl7W1nNW2z+qv9e+KAq5E0LrMPRdEh77OUaA3gSAYtvqYZDTnoMUWRoHYpZ/N61amCbM
         FODWjT9tuvUHTTcS9P4/TS5xQqXcdXnodgCZwzhxgJdgk7END/A5NYySjjAoCHXCA2Sl
         CJ8+daL2AYS9zUN27uul/aK7qQcd+1GBy+MIYFp3QZQzpX73KNyoYvmg+ETFJl3xVyIE
         VjI9WEFrXvGRzwTzNv9M72ZJgxFIPHdtPZkQRuPyHS7Dk0+h6J/8Q+dR1i76ok7OcOr0
         FFXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbiRhm1Zg7rquLx42NEKwVZA+MF6SL5G6jIMe2mUC60NOs4vj0FZH+ydwiRPXDLX0GPSZtR+I=@vger.kernel.org
X-Gm-Message-State: AFuF++mdXZKJwBpE/dUx0Iy3afiPfsEIcLHXhQeWw/nk8U2j7K+JNAVP
	fJPoUBB0K48aR1iVD1CWielSsfQqPStOXzl1nRMJag7E/ChCnquJEEP+
X-Gm-Gg: AYBFou1pWrjS6OzYbu7KlBaKCMiqV1lSOBCBonh7m18R2LC/ccVQfpHPcFObflcwycK
	PhlceC/puLtLfHilNVu7/pL6bxIW0+6snkzPYUy/ONYIqsgKYwG5MLwMU0HiOrbtxn0bs7P7sRp
	zUNiL/ijbw5LuX66LVO4tPqkyx/TV57fO3oSsPDtK/DRLJYhdwcBL2P8+mOUqWHcsSQdig2lyho
	kZR9PtBhq8tIXVhfxhY5NV70z+b7nAqJ0v1OOaUhvsLg/URC7HrkkmFeFHAfmhLQqYfFpmJLqqf
	JJnpDtgxXw/SNGqLovjmncxDcdal8vD1P2ysTB8pFhLDH6Yddb0eAU3+2IIm+GQkq/0dvvYqbyD
	AOCPBjTPT+nZwJO2evpVNo3g6+/9VnGRhfygZ9Pe5f77Fuu9ZGiVu/ek/Dthz2/kdIV+caspEzQ
	Okn+dHKddDXKASJTlspZTLrf0tBZDTS3DLLaRNzIWsJptp8sQ12z6sxf4kTIRzgwp0epjmF2RYO
	Wm4ZyVrc+x/j6C2xh+C4kiTqI6gknv+L7RNK4pEYGdVCUlWmZ6tLNIurXxkT+g=
X-Received: by 2002:a05:7300:f542:b0:34e:f5c3:96a with SMTP id 5a478bee46e88-3515deca0d3mr5836252eec.39.1791452394628;
        Thu, 08 Oct 2026 02:39:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3002:e11e:c053:ebcb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm6873252eec.17.2026.10.08.02.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:39:53 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 08 Oct 2026 02:39:42 -0700
Subject: [PATCH v2 1/2] wifi: carl9170: Revert "carl9170: devres-ing
 input_allocate_device"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-carl9170-reverts-v2-1-3ecb12089797@gmail.com>
References: <20261008-carl9170-reverts-v2-0-3ecb12089797@gmail.com>
In-Reply-To: <20261008-carl9170-reverts-v2-0-3ecb12089797@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>, 
 Kalle Valo <kvalo@kernel.org>
Cc: Christian Lamparter <chunkeey@gmail.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e6826

This reverts commit 87ddb2fc29f10cf689ff0dfb88a19b7d3687006b.

In carl9170_usb_disconnect(), the driver calls carl9170_unregister()
followed immediately by carl9170_free(), freeing struct ar9170 inside
.disconnect(), while devres resources are released only after
.disconnect() returns (and devres on &ar->udev->dev is not released at
all on interface unbind or registration failure), leaving the WPS input
device registered with input->name and input->phys pointing into freed
memory.

Fixes: 87ddb2fc29f1 ("carl9170: devres-ing input_allocate_device")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/net/wireless/ath/carl9170/main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 61c7a1288743..702b6d113b18 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1500,7 +1500,7 @@ static int carl9170_register_wps_button(struct ar9170 *ar)
 	if (!(ar->features & CARL9170_WPS_BUTTON))
 		return 0;
 
-	input = devm_input_allocate_device(&ar->udev->dev);
+	input = input_allocate_device();
 	if (!input)
 		return -ENOMEM;
 
@@ -1518,8 +1518,10 @@ static int carl9170_register_wps_button(struct ar9170 *ar)
 	input_set_capability(input, EV_KEY, KEY_WPS_BUTTON);
 
 	err = input_register_device(input);
-	if (err)
+	if (err) {
+		input_free_device(input);
 		return err;
+	}
 
 	ar->wps.pbc = input;
 	return 0;
@@ -2044,6 +2046,13 @@ void carl9170_unregister(struct ar9170 *ar)
 	carl9170_debugfs_unregister(ar);
 #endif /* CONFIG_CARL9170_DEBUGFS */
 
+#ifdef CONFIG_CARL9170_WPC
+	if (ar->wps.pbc) {
+		input_unregister_device(ar->wps.pbc);
+		ar->wps.pbc = NULL;
+	}
+#endif /* CONFIG_CARL9170_WPC */
+
 	carl9170_cancel_worker(ar);
 	cancel_work_sync(&ar->restart_work);
 

-- 
2.56.0.385.gd3acb90ef8-goog

