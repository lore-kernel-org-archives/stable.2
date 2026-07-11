Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB3280CE5
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782375; cv=none; b=u4dqNtcH70umjgfr9OXBpUTnjCn/JxFlJq3sfLP3BJCVee6b3VCE3vmsPcucCaHvum7MHjVv9DBWJe1ScoQ8aZSU6KtF7JsSl0Tgx8Zuqy1Q0D95fxSzJtf+3EECKjCqtUWAUz1jI6tKGflUsu4yNvsfO8UECnX6pZM7gKzCx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782375; c=relaxed/simple;
	bh=S4tnd3gU6E0U7OZ4HKFPKwlMp4QR6VJmRDUS5NtF2D8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4UgxqUD+GVUQA6j2ZrqKKYoFltnOwR/kGDuRjKxWAvu1nFliXMLsIyXehhblgy0obKEemaP6e3G157U77zQCclO71VsIb6V44C4IxW8XD+qg25GXQbch5VLY/64j5NSyn69HX2CFsiqqm25wJKP8+nmP273/AKuHawNMYDfumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaIB+0pZ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaIB+0pZ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5d50b0dbso121776485a.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782373; x=1784387173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/GKREJqWw2SSprYGaRAlQGLw7OTwwGCr4lR4AMIblRM=;
        b=IaIB+0pZtIMq3YKkGd0S+QkIuAOPdidHFry21OP5ESYPHMH7gu/kXtHD5te/fBI78t
         prey7qedh2k9DUhZzTWJVQvmyQoX9RtoR7hCIWq2eba09EPg+1C2Wvs9+T5xc5xXFVYi
         nBpf9LG6TuZ4jkXfA5xkLOMhdRMSCVEmhhkIlBy+o9RKG1uQ4t8Kj3cLtdvU8jPwqL3M
         2kUZHcgIpuHgElt3VoREgDNCdEG/iiP0IoGDvEHpXV7TyHiXXrtYwUEd/8PKZRKcD6dZ
         XkK4Ae4KP8QBmBs/oYN6h52VzH9verACr65WuA0CsAA8TDrgIIjdanfYDxJxIyBMnMZr
         oRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782373; x=1784387173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/GKREJqWw2SSprYGaRAlQGLw7OTwwGCr4lR4AMIblRM=;
        b=SWvxT79/lWFW0nu9anCoW0UEjDRxaImggB+gv9Eu60xYCz6OsU0GzGNc3peuK1RqOA
         tlgtCYmkrOpNFrhfwb9iWHPPWspooUPJjgZwZQ1+HErFiC9edu8obSBb6DiVAN0pMzBr
         fFxR2Jzvcqi42LDr9iqcqagECoL/14C2mHZ2Uf13EWQY6/JcH4CKvp+hx79CJ2qqqc1i
         Nl8wgWjqtV+U3ZVO3zJPb0nHZEFASU4kN0DFAiEpbF7sb9OvDVgh0mlkI93iIE3c1SKK
         LlgatwCAdlgV7sM/yGKA7nMsOxyix9r0kx6ZLNtmnQrK9DbIBAnNiILRxg49rpG67+D2
         O0mg==
X-Forwarded-Encrypted: i=1; AHgh+Rqxh0bhwQmal3FrYn+rdh4ClVSQu5oROEUG7Y/HyzfGqaWOPDuLtJjJljF7OHKKEf44g6JHSog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbiX/6FGCO6uDffvl+hgvxdh2mtG3p1MSmqgXH6fKpgzpV/iEc
	WiW+R3VyRVcJjlNmBPb/LFH25B2JUru01Ywp4tp2CL5k3vgu6CLm3n3WMEK3gFrywxQ=
X-Gm-Gg: AfdE7clr887H3O4EhkP4tHXtNgUFRf36fFzCDb9l2U4WYGgd0QR20khyd/Pn+H9QtWO
	Efd7d+gIFkEB9BwIB4yFmWfIM80yDVf/nXkTW59XdOrxSvyIebAH/Q6DMQzRmgliRBQ79VFpwZl
	5KKqmfSH30KqSh/zunnkGx8zUs3c/ObIkDVc1FF7I2bKvaN6oQFCq9aNGa2OZHCg42BlcOrGPz+
	QNmS7Ej5AnHGu7UGgJJdnvNNw/lGzVhX+UV0I9PXygkzhHj1XWu3GpAtOlE7J/gUuQ6MUAZZyDq
	8p2Kd0tYge9tYrXpaWp7jNhYgMBTbyU76OD0RzAyqGmSKikpq4FZ8bUtqn9+P1xqfnmelOwnfYc
	ArFGEleO8FTqJmV85bHRtLLJ+OqvCH1huWULREhM2av20Y2Bq7JpB5Jpsx8+Hw2wZNPZA8Vy9YM
	+NgMWLf5qgnzLhTt9Awp8ewqjJGrWiEOHrwxKJyqY43nJl6tcw5P+DATKgAFEkzkCCpXPjSZdVn
	wg0iCAB1g==
X-Received: by 2002:a05:620a:3941:b0:92e:6864:b83 with SMTP id af79cd13be357-92ef2c131fcmr396322685a.69.1783782373374;
        Sat, 11 Jul 2026 08:06:13 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d68e5fsm464578285a.43.2026.07.11.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:06:12 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] wifi: iwlwifi: mvm: bound BA-window station ID
Date: Sat, 11 Jul 2026 11:06:09 -0400
Message-ID: <20260711150611.2913332-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

iwl_mvm_window_status_notif() extracts a 5-bit station ID from the
firmware's BA-window status notification (values up to 31) and indexes
mvm->fw_id_to_mac_id[] with it without first checking it against the
firmware's station capacity. A firmware/backend notification carrying an
out-of-range ID reads past the station map.

Patch 1 validates the station ID against mvm->fw->ucode_capa.num_stations
before the lookup, matching the existing MVM station-lookup helpers. Patch
2 adds KUnit coverage: the malformed out-of-range ID and a valid-ID/
null-station control that must still pass.

Reproduced with the KUnit test under UBSAN bounds: the malformed case
reports an array-index-out-of-bounds splat on stock and passes after the
fix; the valid-ID control passes on both.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  wifi: iwlwifi: mvm: check BA-window station ID before lookup
  wifi: iwlwifi: mvm: add KUnit coverage for BA-window station ID bounds

 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  4 +
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |  2 +-
 .../intel/iwlwifi/mvm/tests/window-status.c   | 77 +++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/window-status.c

--
2.53.0
