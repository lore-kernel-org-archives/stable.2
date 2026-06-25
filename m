Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1A37C918;
	Thu, 25 Jun 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401173; cv=none; b=fpUSYzW1kecr2OnNrY2xc6hjoES0oTRlfSpsZr0ZzWie1ZpyexACsjcpHfjVE0c+AlmGAoLXRNPAIMJ4kq1XdwsRpyzirloIPSee1XrLimUbZVrq+2RtqrWz2JJuq4RDMOVjk8i9j4fSVJ/SvYEss4s71lLgJbZTGxGqVLv0ldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401173; c=relaxed/simple;
	bh=QDSOj/4/w2gbarjned5kuy5E43lZkbh7k7a9mdMLyBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GE3MAlnG4GR/JInp4e+dkpA3cYkl6Ybdf63J9QF2KteT9aVC1ATQqLMxoblvKlped3gEbVofmRzy+56DMGm3ysA+1sTHhAdARU5iWJIzkXZcq5mpy0VTr2HjmU/5vvCRVUOWGj0wwmnBnEyaW5MYBRyeuhSG5TK1I6ShbhZzVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=e07tngQX; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="e07tngQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401169;
	bh=5CnqIZrXbOvj5YTogFA5mNwwB12cmB+wEc2uMYZ9VoI=;
	h=From:To:Cc:Subject:Date:From;
	b=e07tngQXAOEZscw7ItyoLzxMsp7Ue3bldidYfHVIzLCq6lk4TxQcueMgQ9+yxl3dz
	 3xNtlINvBBG2n81B7hmWnqomB805PfqiomxKlInI5v4VW66KJAMOqJW6Q3z4tMAQH6
	 yD4iwzTxJJ6gJBE8x4H+AFLjVPljCZbA1sYBgB6s=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gmN1Y5KFRz10hn;
	Thu, 25 Jun 2026 15:26:09 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gmN1Y0NDvz10j8;
	Thu, 25 Jun 2026 15:26:09 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v3 0/4] sys_info: prevent duplicate backtraces
Date: Thu, 25 Jun 2026 15:25:54 +0000
Message-ID: <20260625152558.7450-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
When they strip that bit, an all_bt-only mask becomes zero and sys_info(0)
falls back to kernel_si_mask, potentially duplicating output.

This series adds sys_info_with_filter() to filter specific bits without
triggering the kernel_si_mask fallback.

Changes since v2:
- Use sys_info_with_filter() instead of sys_info_without_all_bt() per
  Petr's suggestion
- Filter applied at __sys_info() level to handle kernel_si_mask correctly
- Added panic.c conversion

Bradley Morgan (4):
  sys_info: add helper for callers that print some sys_info on their own
  watchdog: use sys_info_with_filter() to avoid duplicate backtraces
  powerpc/watchdog: use sys_info_with_filter() to avoid duplicate
    backtraces
  panic: use sys_info_with_filter() to avoid duplicate backtraces

 arch/powerpc/kernel/watchdog.c | 12 ++++++++----
 include/linux/sys_info.h       |  1 +
 kernel/panic.c                 |  2 +-
 kernel/watchdog.c              | 12 ++++++++----
 lib/sys_info.c                 | 20 ++++++++++++++++++--
 5 files changed, 36 insertions(+), 11 deletions(-)

-- 
2.53.0

