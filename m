Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93337F739
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365238; cv=none; b=fSeTg4+13I86oEPmkyLCLbXfiGf4CJZsd3ZNhORPnAsR6RUSYJwwrNU2p1/GDxoxyAzeHPeaQ1JqFnCMb2xQYoJlqGjMf+fugJIfG3yJhnAkqmW1VgV8Kjl5291i+dOy5n88FgvhXPYBECK8YK/jVE7Yq7Gl81LezVNUx+LyDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365238; c=relaxed/simple;
	bh=HPNjM4pLTXiNcEfRHrL4hLZd+ZNQ6uJ5GqL3xE76LSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTOmvIu461HUNL8Vkj5Lr+RIBZKkjAfSgMu4jbtelAAgCBofVDXYz+zURgie9Tj5gQ58Wp5M54hy7i/C3P1x2l7DEQC9qYRJjKDA270yQWuEmp3RME5oI2D3CfgcgWsFRcIf4PV2fjXU85B7bxK4EoYMPqUyUcI40BKyhnvj88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Krk6jWUl; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Krk6jWUl"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso1587396a12.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1789365227; x=1789970027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xn+mk68vbRuJzny4Qe7jPXp4/GOeEinEUjVmXKpW8GY=;
        b=Krk6jWUl7RgfA6pLSCvyQmk6WoDoOyMF1TYvdA7M7xyMaienNZQzOHg/EDDabwn00t
         iBgvYlv9Cc0OgWZqekr/3rXUtmlztpK/11xvBoV9OVzWWYiELeyQLdBfx+MMsaQyGtJL
         Ko/Zz1uF0zy/isp7TD6/vTmnmERHBFVp7baFC3SVYtBJqfamv9U3lD7vMND66PouiWi8
         H9xgPUsuPDL3/FoaI1B8R0mRFqybc/6C0jSUDhLzoTz/GvdjpTNrIXIq3rW6ijMz7Q8O
         sFJjM5MOcbl9s1pJrZZGVM2jjPQGm+/Z3WBwPwgA9OAfVyj5//Fl0ABS9eb0gUZUyrUs
         aaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789365227; x=1789970027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xn+mk68vbRuJzny4Qe7jPXp4/GOeEinEUjVmXKpW8GY=;
        b=bAZYg53uG9qe3CDQnzQw1POTUMC2MSbGxOw7EAfrUam7Mb92DQeIf2jyQJLfwzQYls
         Pb4AHJIMWvd9/imLL7Pjrx/DbtKlq+d2RHHpZg3zW7Izg00iQ0pJtA19J/oN9rewoIvF
         3qABTEG1bh9sMUzDidjro02+BZ7bHskd/Bulfo0OBGckOWl+eRAykoDCZibqdLsl1bzX
         53nyPSKU8mHwkFGZpp+12LVd/OrqhrMXHDOON9mf7GbhM3TQFQVn+5k0xuxQZFUs3as3
         Op9CWXnlCXRuxpjcwTq+wjkk+ldH5YfiGQQSg9H5VVSmqJJTFcDw2cD5HnGLb2vAYQO6
         FzHg==
X-Gm-Message-State: AFuF++nZ2R03CshXEajPDWB1I9iIQA34mTtU2CceCEwRyPoTsoUflvX7
	FbDWkXmdBCewqviVmIE+DvruEFgdQ89sjjOuTA4xbsbFkDyHE6uxFbS8wy+XqcKgY+m+UpR22mt
	ivXO7
X-Gm-Gg: AYBFou3cHXS8Mz2n4pDaRFTScSkCs87HiE1uUlRV3VdN8TxeBUWMTVPJ3XHhp7GvGqn
	ICOVDt0bjuHCgIqRd1Tiu2O1Hvn5GmVlRjxW9m7cYed70xv+obJwW01qXaFrvthxpf0vgpyHahd
	WirnBAAgIw9ucK+Sm4naDcypS2DOq4fIEPCLtem7o2N/DbABuUBbR8CvnUS0vnfDSXddqDohrx2
	jTCDOrHhIlV5jbElTSoLIYprFZVuob2TOKxwct9ldQBtdZ6O1ZyaarMUvtgPw68wKwrG2vzFR2E
	xq/h4inoxaJ6kX6q9xTrzxlsnBEMMUbzZUPC03FdK3X5ZNasfcQbjF4ekFQ+5aG3lpdvu2+ewIJ
	JRnGuGzWhJQOGDgrxEXQZ+qwVuQEBj2rbOdyft215ezv4ZGRD0V8Zjx7aOS3Bi6JVO7W2DkvcLA
	3K2wfPuq0l+TG9z+3H/IU1PJ9BPw5LzRaKqZqinKwiZ8n4RXp7bccafN4xT32z+AmY/XZslXatr
	CdrBkVdlrRJYSd3WrriZZYMUGikQVs7rx/ICpVOKyccW8eQsOsPdtFAyV35zt8fSgVQ5ZWx
X-Received: by 2002:a05:6a20:3952:b0:3d8:f78a:9349 with SMTP id adf61e73a8af0-3db4064eb17mr2028000637.13.1789365227289;
        Sun, 13 Sep 2026 22:53:47 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:65f8:1929:8ba0:e395])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b97994sm42674102c88.12.2026.09.13.22.53.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 22:53:46 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please consider post-v7.1 CVE fixes for 6.1.y, 6.6.y, 6.12.y, and 6.18.y
Date: Mon, 14 Sep 2026 01:53:41 -0400
Message-ID: <20260914055341.86197-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and Sasha,

Thanks for taking care of the earlier requests. I found one final
direct-pickup group: 26 CVE fixes that entered mainline between v7.1 and v7.2
and are still missing from one or more supported 6.x trees. The Linux CNA
affected ranges include each target listed below. I left out anything that
needs an adapted backport.

I checked each of the 73 commit/tree pairs separately, then applied each
tree's full set together after its current stable queue. All applications were
clean, and every changed path built with CONFIG_WERROR enabled. The cumulative
x86_64 allmodconfig kernel and modules built without diagnostics on 6.6.y,
6.12.y, and 6.18.y. The 6.1.y build completed with four unrelated objtool
warnings; the same four warnings occurred on the unpatched tree. I also built
the CoreSight object on arm64 for each target where it is requested. I did not
runtime-test these fixes.

Could you please queue these commits for the trees shown?

  5152c6d49e3fd4e9f2e857c57527aead752f1f87 (CVE-2026-68097)
    Targets: 6.1.y
    ksmbd: validate ACE size against SID sub-authorities
  ffb2bd7ade36ec4da32c46a6eddbf4515316d08c (CVE-2026-68161)
    Targets: 6.1.y
    sctp: close UDP tunnel sockets during netns teardown
  fd098a23bf8fda7eae48db9b06e7c34fc4d228fa (CVE-2026-68286)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    drop_monitor: perform u64_stats updates under IRQ-disabled section
  7089f7ab99c89f443c92d8fcc585e63f2727f0b3 (CVE-2026-68287)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    drop_monitor: fix size calculations for 64-bit attributes
  5e9c8baee0329fbefe7c67aea945e2a07f15e98b (CVE-2026-68288)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD
  47f42ff521b4eeb46e82f9a46a4783a99f7570d7 (CVE-2026-68289)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    tipc: fix integer overflow in tipc_recvmsg() and tipc_recvstream()
  7dc3680b7ffe01add3e9299fde8471d2dd53a8ae (CVE-2026-68303)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    drm/vc4: hvs/v3d: Fix null dereference in unbind
  3f4920d165b29052255527d8ae7619e7ec132ece (CVE-2026-68337)
    Targets: 6.12.y, 6.18.y
    bpf: Reject redirect helpers without a bpf_net_context
  da55f570191d5d72f10c607a7043b947eb05ea46 (CVE-2026-68391)
    Targets: 6.1.y
    Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
  e054c1a6ae7310d2815778fddb87da616e11c255 (CVE-2026-72334)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    Bluetooth: ISO: fix malformed ISO_END/CONT handling
  5c6ce05e406520290c1d89da97fb3cd70c09137d (CVE-2026-72355)
    Targets: 6.18.y
    netfs: Fix barriering when walking subrequest list
  72a85e9464a5332fb2cd7efd26d9295275ceda2d (CVE-2026-72402)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    bpf: Mask pseudo pointer values in verifier logs
  9f58a0a4d6c2ed5d341bba64f058f15d1b0c36f2 (CVE-2026-72413)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    sctp: fix err_chunk memory leaks in INIT handling
  393d687131d8aa8c7e4de2cb494438e145d20fc2 (CVE-2026-72438)
    Targets: 6.12.y, 6.18.y
    md/raid10: fix writes_pending and barrier reference leaks on discard
      failures
  1563ae33dc4f5ebac96b93af2ef72e72aaaa31ae (CVE-2026-72485)
    Targets: 6.6.y, 6.12.y, 6.18.y
    coresight: platform: defer connection counter increment until alloc
      succeeds
  d9c8c45e6d2f438a3c8e643ae78b59454fa0fadd (CVE-2026-72494)
    Targets: 6.18.y
    RDMA/irdma: Replace waitqueue and flag with completion
  87267803a8c824616eb147c5dad7030a5db6f878 (CVE-2026-72496)
    Targets: 6.6.y, 6.12.y, 6.18.y
    RDMA/bnxt_re: Proper rollback if the ioremap fails
  4d87a251d45b4a95eb4c0abcfab809c9f231258a (CVE-2026-74258)
    Targets: 6.6.y, 6.12.y, 6.18.y
    bpf: Guard __get_user acesss with access_ok for uprobe_multi data
  e26657fe3b85c068b01f42bb0c602f242d643ba9 (CVE-2026-74269)
    Targets: 6.18.y
    bnxt: fix head underflow on XDP head-grow
  06b693d2eb6651a63ad85bad8673de3b7d4edd6d (CVE-2026-74289)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
  b7e44d1986d6671342c19b82192189ca5db5dab7 (CVE-2026-74291)
    Targets: 6.6.y, 6.12.y, 6.18.y
    ASoC: topology: Check PCM and DAI name strings before use
  d65adf85477247be04ac86886f8edfaa047b5d4a (CVE-2026-74294)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    ASoC: meson: aiu: Validate written enum values
  8c79aac429b583301f387374ff37c59be671df87 (CVE-2026-74407)
    Targets: 6.18.y
    wifi: ath11k: cancel SSR work items during PCI shutdown
  e8bb506e6ef749ac0336f3e579d8d02396b7d832 (CVE-2026-74521)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    ksmbd: use memcmp() to compare ClientGUIDs
  9006c116dd111d457bf5d074990210f70a4ad2c8 (CVE-2026-74735)
    Targets: 6.12.y, 6.18.y
    l2tp: fix tunnel and session refcount leak on seq_file release
  594d905195024b228c962627ae5ae7c17bd582a4 (CVE-2026-80521)
    Targets: 6.1.y, 6.6.y, 6.12.y, 6.18.y
    af_unix: Unlink scc_entry in unix_del_edge().

Assisted-by: Codex:GPT-5.6

Thanks,
Artem Dinaburg
Trail of Bits
