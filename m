Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0E463B60
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141711; cv=none; b=It7+ghDjDlU8yln06leLsJ9miQCNvpq3j4OMysEIXDF5gtxr+mVZLWMkNRXwkGmmvttbWjIcUYdoaB4RxCUVkoossk1o5qDrSlDG1gJbCB3G2khK1pdGiGeRdSwIZimp+mPVZrzgzAO5Gz5DCLSFTEgkpQnRezIaAn8IH43UYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141711; c=relaxed/simple;
	bh=I5TiNDHhuywIDRB1uPbLIoFF6zJCShofMJ9h7rnmy+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ur37NmF+/nSIxZEuWhm5VRhd2pz6E5wFSUvEJT7jMUhe5fqNNNFjp/5WvvNazJX+h3AY5XlIdoVvpzSNmjMesLgHKJ1bS144MwWPnUms4UIxjOA06/YADR/YJzJ9kdGcmBHgwAql3xguWT0+QoJfAtNLEt7B2bI7V++jF+HxbPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Tqrjy495; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Tqrjy495"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so508655e9.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786141701; x=1786746501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CryompZ1dW6ZoEDRWoxN/i7VhLUldGpdjdbtrnbnsQw=;
        b=Tqrjy495VuMVlQ0L2uhDTYBxRlmt1UieuZgb612J69BH1MYvmdae9NN5DU8Wz3DAHq
         dy67cW4gMTMoA/rY+KgyQRCNIG5yPQUPLiXthPCfOLI3pvX+n/gG3HXaSYTBWGGT1ZUj
         hx+/WJ3oJhec27MCN4+KXipP81guSbZnJTY55NC1RnHXzhlx4JqZJ+XrTFxiXqH2lgHe
         +T3m/7XwDyxuOfe6Zw2jBYJhublzp8cCSWQbqjpWOm+aIwAuuZP3SwB9ocVly1tavR8V
         DgIxlJGWNcJvISjvRU1XOJs7Ck3CF3hxXyjv5M1y8w8LvDLr5np/IPeKXTcqfJ4oLFiF
         bibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141701; x=1786746501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CryompZ1dW6ZoEDRWoxN/i7VhLUldGpdjdbtrnbnsQw=;
        b=PoHfro5lqG+qYFtZR0IV7BYE5egLKS8xTtzkjvp9Upgg/sTLY7Z0T1Cqo29xRHzVvR
         wb4HjII5vBziex+gVx9bd5IGXoi+TE2bkBM9/AE4V6exEQZ69/8pKYdHS6Ua7Kzzdn4I
         sOODHLEPuldPG6+jWYfMpM5eEw11R3xssk0a7KouDAzVvUkFMFbyPn8g0EU59vBQGoOQ
         dVM/hWVWFwT0qpepH8ro9tQwwxEj98LluICcLWNlFt7HyQqrlRpN7jWIaxiGuNPUJciw
         l4dZiH3BRr/j7FYWC4yZPl5JM8fHp4c2hmQ86XSVv3YasQd5RTLJUowjWTS9zyMSfrsW
         1RMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHPWQ4u3zsb4AEyTFols7MdmQnUGu3lFlsNMni9fVvfZLsn8W8mfCAUWKPt8RdOwQ6slmFBgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynXy1V0sM9an9QeeEA6LZ3Wdmd0RwIhav9lP/De8XPmo0OJ4Vr
	gcsn2kGsW4a7hYQA9eEWYtvtOwriOkfXug/dZ3OctTl1XUjksg2V4LhE6Wp+UienG44=
X-Gm-Gg: AR+sD12HptoBZy8KEX1Y8Hb6u84xTlkgi05yndhAlE+g83YRhlyb7aaEgp1jeS1c9Cz
	HWiHaN2x3Rmj6jZMMZ6LcJppOAd/nN1P5Xxl/teuhve3XDWeXLRt6KBuM9abhHVrfQHWAeCjd7s
	k80zJ0gTJ9Ri0w1fmyT15jnrTMSRxOH5KplyVr+Ia+oyo5YfEYw2t4PnaKL/fe/OG+pEDOx7FI2
	ujMyhVeZNqZaajAk73+AB/4c1fOks7miGzlmTj9ixLa47xkC8gYk6jSK7VJefxCTXFQ6E0DYe9A
	qGdRYQcja6UZTS/m+VSAAZWTCbUdlDRISGkgekNCFW2iQhMIHjOubNQLGZnRSZGf5TPMzhUAE9q
	L2owtzFJuhbgKVPxH9R4WpW06dhY2Hae3bdaLseNuP5IpClPhSDoHl9BP+R0hTz6Gk/od8qppD9
	R4GZXTxw3aHXPVtl1JfYFAGvxz5pUvy17BVziGkKeo/zJkLn0Z6Fw/HupIcJhaZWfm2+G78M5ph
	cNzjVjhgAXdmBU=
X-Received: by 2002:a05:600c:4ec7:b0:499:5c3c:41a5 with SMTP id 5b1f17b1804b1-4995c3c41femr103855655e9.0.1786141701250;
        Fri, 07 Aug 2026 15:28:21 -0700 (PDT)
Received: from dev-jrangi.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995dee21dcsm82748425e9.0.2026.08.07.15.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:28:20 -0700 (PDT)
From: Jasjeet Rangi <jrangi@purestorage.com>
To: x86@kernel.org
Cc: jrangi@purestorage.com,
	tony.luck@intel.com,
	bp@alien8.de,
	tglx@kernel.org,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-edac@vger.kernel.org,
	stable@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	yazen.ghannam@amd.com,
	avadhut.naik@amd.com,
	msaggi@purestorage.com,
	rjethwani@purestorage.com,
	rhan@purestorage.com
Subject: [PATCH] x86/mce/amd: Fix inverted interrupt enablement during storm handling
Date: Fri,  7 Aug 2026 16:26:59 -0600
Message-ID: <20260807222721.2795123-1-jrangi@purestorage.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mce_amd_handle_storm() currently does the opposite of what storm
handling needs: it enables threshold interrupts when a storm is detected
and disables them when the storm subsides.

In addition, machine_check_poll() -> clear_bank() -> amd_clear_bank() ->
amd_reset_thr_limit() will unconditionally enable threshold interrupts,
which undoes storm mode behavior.

Fix this by disabling interrupts when storm mode is entered and enabling
interrupts when storm mode is cleared. Also make amd_reset_thr_limit()
enable interrupts when the bank is not in storm mode and disable
interrupts when the bank is in storm mode.

Rename mce_handle_storm() parameter "on" to "in_storm_mode" to
disambiguate its meaning. This includes updating the Intel storm handler
parameter as well.

Fixes: 5c4663ed1eac ("x86/mce: Handle AMD threshold interrupt storms")
Cc: stable@vger.kernel.org
Signed-off-by: Jasjeet Rangi <jrangi@purestorage.com>
---
 arch/x86/kernel/cpu/mce/amd.c       | 9 ++++++---
 arch/x86/kernel/cpu/mce/intel.c     | 4 ++--
 arch/x86/kernel/cpu/mce/internal.h  | 8 ++++----
 arch/x86/kernel/cpu/mce/threshold.c | 6 +++---
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 83b04e02417d..fd8f7ce4f38b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -842,14 +842,17 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }

-void mce_amd_handle_storm(unsigned int bank, bool on)
+void mce_amd_handle_storm(unsigned int bank, bool in_storm_mode)
 {
-	threshold_restart_bank(bank, on);
+	threshold_restart_bank(bank, !in_storm_mode);
 }

 static void amd_reset_thr_limit(unsigned int bank)
 {
-	threshold_restart_bank(bank, true);
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+	bool intr_en = !storm->banks[bank].in_storm_mode;
+
+	threshold_restart_bank(bank, intr_en);
 }

 /*
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 4655223ba560..3e3cbdc4fedd 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -147,9 +147,9 @@ static void cmci_set_threshold(int bank, int thresh)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }

-void mce_intel_handle_storm(int bank, bool on)
+void mce_intel_handle_storm(int bank, bool in_storm_mode)
 {
-	if (on)
+	if (in_storm_mode)
 		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
 	else
 		cmci_set_threshold(bank, cmci_threshold[bank]);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 85bb474f2f44..287ef4a8223a 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -41,7 +41,7 @@ struct dentry *mce_get_debugfs_dir(void);
 extern mce_banks_t mce_banks_ce_disabled;

 #ifdef CONFIG_X86_MCE_INTEL
-void mce_intel_handle_storm(int bank, bool on);
+void mce_intel_handle_storm(int bank, bool in_storm_mode);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
@@ -49,7 +49,7 @@ void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 bool intel_mce_usable_address(struct mce *m);
 #else
-static inline void mce_intel_handle_storm(int bank, bool on) { }
+static inline void mce_intel_handle_storm(int bank, bool in_storm_mode) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
@@ -270,7 +270,7 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
-void mce_amd_handle_storm(unsigned int bank, bool on);
+void mce_amd_handle_storm(unsigned int bank, bool in_storm_mode);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 void amd_clear_bank(struct mce *m);
@@ -303,7 +303,7 @@ void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
-static inline void mce_amd_handle_storm(unsigned int bank, bool on)	{ }
+static inline void mce_amd_handle_storm(unsigned int bank, bool in_storm_mode)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void amd_clear_bank(struct mce *m) { }
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 22e4c916559f..14e4713adc53 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -70,14 +70,14 @@ void mce_set_storm_mode(bool storm)
 	__this_cpu_write(storm_desc.poll_mode, storm);
 }

-static void mce_handle_storm(unsigned int bank, bool on)
+static void mce_handle_storm(unsigned int bank, bool in_storm_mode)
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_INTEL:
-		mce_intel_handle_storm(bank, on);
+		mce_intel_handle_storm(bank, in_storm_mode);
 		break;
 	case X86_VENDOR_AMD:
-		mce_amd_handle_storm(bank, on);
+		mce_amd_handle_storm(bank, in_storm_mode);
 		break;
 	}
 }
--
2.50.1

