Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4124477F5;
	Thu,  3 Sep 2026 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434020; cv=none; b=PO1Q/TPpNGzopfmutd6ymE2oncOI32JpQOolwgHLydiAH3azp0c+rgxPhphQTTDi8k71BKkNdwV7IxYGC8+DHFG6+5TkAuoFj29x4RxUH+mtQpsyyyqVjxI0K3j7TjX0Olh0SohQ/PL+wVxLk3AWL6SJzsTMfEMKvxHFbLhLw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434020; c=relaxed/simple;
	bh=gPYwRqW+L5sJ+ARi5KxOeBt+b7L4EDNLNGZRjk2aCDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Dzyk3OVoQIlWmVyunnjEx5NBCLeq1fWO6KVTodveF/9RnVnotgopVJU+V3GLmPzwV/+ipIFZBmAfPxnrmTstS2n+a8EFKSRwA6VZpdbzdk8ywjo5NsRgbz5vwSpDavUJBXJVnAnwYp+o+QfHO/E/3ESY0qWw9tA9qgk0z75uwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vgJfV9Fq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vgJfV9Fq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27FA71596;
	Thu,  3 Sep 2026 04:13:34 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7008F3FA32;
	Thu,  3 Sep 2026 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788434017; bh=gPYwRqW+L5sJ+ARi5KxOeBt+b7L4EDNLNGZRjk2aCDw=;
	h=From:To:Cc:Subject:Date:From;
	b=vgJfV9Fq/knU7DdNOR3my+epk4zUL1Q1mZ74mVIUNSV30CjVIseQnP4F/bHSliFpe
	 GGxR/kRjwZPR5jBHa+g33eiuL2us+5E4WfLtrNrRxJzfWQd0OLRpq02GYP4lNg9Ams
	 GFfeLBaykfPvVNOTKz4+XJj2ZqVeo0GWI8RaQFnw=
From: Christian Loehle <christian.loehle@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: breno Leitao <leitao@debian.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] mailbox: pcc: Fix shared-memory teardown race
Date: Thu,  3 Sep 2026 12:13:26 +0100
Message-Id: <20260903111328.805352-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Breno’s fix frees the PCC channel before unmapping shared memory, ensuring
the IRQ is disabled first. The second patch serializes channel release and
request so a new mapping cannot be unmapped by the old release.

(I'm happy to have my patch folded into Breno's if that's preferred.)

Breno Leitao (1):
  mailbox: pcc: Free the channel before unmapping the shared memory

Christian Loehle (1):
  mailbox: pcc: Serialize channel updates with shared memory teardown

 drivers/mailbox/pcc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1

