Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195796;
	b=ko6nHqXA27hvct24VTFnhIwmWZeXkjM86CPwY3hlmbGWTLXJokNGhBu6OVuxR2g+V8jN
	 ejQOheigVpdkOARBbm59OYf6myKDr0XgEc7OlXsSXnjX47CRl1Zp4EqzPO+BZi3RhLFhM
	 pWCDqP7f/fXJQRvSK2nTJ+qTb3WceXP6fi17bGvxblPV6DiIEYZiINshryxndZOLsofFs
	 SvxGPHU7MPR+iRyWPUgGXn8ao3lfHRSqJPEhLJOjfilOJX/6EC+mQDxJcivefnbpVSsh+
	 LgxIc4KP07i/ZiYHyK9A9HoMjEY/WzlAVolLK8u6vh/+kWhacpVcoJRcMIT7GF39KvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195796;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oW/PveCuQ5JM7ohOUMNi3qcUSCoWuYEn+oLybhF/xoA=;
	b=3A7bGLNAdk58Dgo4AA2MfkTN2AohiQ/LwNwTEo/1ob+zlqOAO/rIgpSBHKkJTuR3Nh7K
	 hXW8xG0docTymWLlNtVnfSaPpEto/u2hS3AoIksMVo/6BSum/x3V9nEYQ+ONMn3TlMZtg
	 BGcmWNSs/M4XPx+hbnGRYvm3lU3dqY1fYib29uXlV9GPkMxVT2Y69pME7e3tv69sy91ZK
	 Qdy8+V+dv/3xHu+GqPZWNHn2Gqrb2YYKeOXi5sSiPX4ndzxrRVA0H6I7w6IlQllopo3k+
	 HvyMSDMvsh0pyNO5J+f9AiMrUoGBQSQSq6VzoKoMdadR7oLEVX7fYA5/2WYVx94cH7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P2VH1nKb;
	arc=none smtp.remote-ip=95.215.58.19
Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5860A2638
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18A5860A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P2VH1nKb
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/HPVnKLrKCABmIOGSs3z7lVqaFWbyhWILXjO2++VUa4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795195794; v=1; x=1795800594;
 b=P2VH1nKbPXZ4cCZlLKLKMlD/hOQ1muEvODtFi/+MYProSSpmsq7h4M09WnK00LWZrNHGOj7d
 xeywB6wEsBRCnjvtqF22KUJ5mE+vgGEazTTNbq2vzngkqU4UqZSK/DE7CIv3/YEzkqDkHBfLrrQ
 9a82xBZ8CcFponccvpQznN58=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 8733609d355f8002;
	Fri, 20 Nov 2026 17:29:54 +0000
X-Mizu-Trace-ID: 8733609d355f8002
X-Migadu-Flow: FLOW_OUT
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <bradley.morgan@linux.dev>
Subject: [PATCH 0/2] powerpc/64: Fix some snafus in head_64.S
Date: Fri, 20 Nov 2026 17:29:47 +0000
Message-ID: <20261120172949.3494131-1-bradley.morgan@linux.dev>
X-Mailer: git-send-email 2.53.0
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

While reading through head_64.S, I noticed two bugs in early
secondary processor startup.

The first patch fixes a register mismatch on Book3E where the
secondary thread entry point was loaded into r5 instead of r4
when thread switching is required, which jumps to data and
traps immediately.

The second patch fixes non SMP kernels where secondary processors
jump to kexec_wait without copying their physical CPU ID into r3,
leaving the next kernel with garbage during kexec.

Tested on ppc64.

Bradley Morgan (2):
  powerpc/64e: Pass entry point in r4 to book3e_start_thread()
  powerpc/64: Set r3 to physical CPU ID before kexec_wait on !SMP

 arch/powerpc/kernel/head_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.53.0

