Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438066;
	b=e3WZt0FwxxIOWk9weOONalNSPsY318KsMj+tTBcW/4DcgBFcBkdgFr8/XuHzGegBgBS5
	 11ilPhYjm3swo7AtMEt4p5rgHbAYsSAXhGqneXcWEmz2gymH8fjPbN6vufiYSuWi15TDf
	 Eh+K9s8UkgmwjCQi7JGG4fDpAfLfnugUYgEBBN2lhh4kYhYmNKxwjBFIOQ40Tdvo+nWlV
	 sC+AQl/eq7xtBVgtT0QsuPmS0XCjoD/4Ub+tCnX/nj+ZU6dB6ABAOUU1VdBPf7GeixRKG
	 vyzrj3aXfLyAlLRFdjASTTruW/lGiFsxG7BOuTWDUqdVxbcCyjufohtC+KGGvVJLB6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438066;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lV6OqA+4ssaJDj1S+Y5UN2saHZp4EROsxBke/tNAscs=;
	b=gOE9n55a+ZLghNQtg+bvxgE4W4C9C2+/HJtT0btVqJrsO2ff4y6rXOVQMFHIjXlcZ+3g
	 oxJ+2MUgth+GyoK56r/VlR2e05Svjk6NpTa6exs7/Irc/HcZiX6vBg01J4O8DTRRk+M5d
	 x0tfVxcKDS77Kdf9PpAj1BRHA4VuLgLZvV1jlL53+YnnuLF7UMt3UhpnQKTCcmiC6N4us
	 kZFLw/hB80tatSGWbfWgGlezgSHiJcskQPYJK9G+XzMk9NQ0K+IaDXCqzDldI8HLtikDw
	 DD0rX2zTWuRrdaMiQ3ttWpbQbD7swroPv8ejPEMExDG68LBH98ah2CvYoz0MBPfF5ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=LYrGQI6K;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533660A2638
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E533660A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=LYrGQI6K
Received: from trampoline.thunk.org (pool-173-48-111-191.bstnma.fios.verizon.net [173.48.111.191])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6ABMxiEx026971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 17:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794437992; bh=lV6OqA+4ssaJDj1S+Y5UN2saHZp4EROsxBke/tNAscs=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=LYrGQI6KyZ0v7IacPJVabY7VNXZz6g8SsTnLCmtrBPbhtr26mxv9spfoKiPLRqrBm
	 Xwj3f0rcqeFvO3zKsey8HhQkNp5aDF7lQYPe19ltzz5+SmlQCKbiXBDsk8hGDD46qn
	 kRl+HQNCqjfTBwv3dL+NiW4oWxoNP5HpyDYikHPkhNVSyDQ71sVDPU5MQVaVossUh9
	 VUtB+ivZJmh8/1pZdqsM9g062zNEVNTY5f4YOzrCiUBDClWIQ0SxCy/vP6xdqQoBLX
	 NIdpmZ+He5Y4lTYq3FqydzDSiDNEbNFi2/bOc5VuvTC1gTPqn2HAwVOudpRCRlzwEn
	 8ZARmrwUR5suQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BC1812E00BC; Wed, 11 Nov 2026 17:59:44 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: workflows@vger.kernel.org, ksummit@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>, Bradley Morgan <brads@mainlining.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leon@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH v5 1/6] agents: add infrastructure for agent resources
Date: Wed, 11 Nov 2026 17:59:33 -0500
Message-ID: <20261111225940.1573565-2-tytso@mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111225940.1573565-1-tytso@mit.edu>
References: <20261111225940.1573565-1-tytso@mit.edu>
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

From: Sasha Levin <sashal@kernel.org>

Add agents/ as a home for skills and other resources for
coding assistants. Describe the skill layout in coding-assistants.rst,
together with the rule that skills only inspect and report, and add a
MAINTAINERS entry covering the directory.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Link: https://patch.msgid.link/20261020161642.3713052-2-sashal@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 Documentation/process/coding-assistants.rst | 14 ++++++++++++++
 MAINTAINERS                                 |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
index 509dbf23a099..b8f2c74e46fc 100644
--- a/Documentation/process/coding-assistants.rst
+++ b/Documentation/process/coding-assistants.rst
@@ -19,6 +19,20 @@ For guidelines on content generated by AI coding assistants see:
 
 * Documentation/process/generated-content.rst
 
+Agent resources
+===============
+
+Skills for coding assistants live under ``agents/skills/``, one directory per
+skill with a ``SKILL.md`` entry point in the `Agent Skills format
+<https://agentskills.io/specification>`_. Each skill points at the process
+documents that apply to its task and adds only what assistants tend to get
+wrong.
+
+Skills inspect and report. They do not change files, create commits or tags,
+or send mail. A skill returns its result with the evidence for it, or says what
+is missing. Do not fill a missing result with a guess or a placeholder, and do
+not finalize the work until it is resolved.
+
 Licensing and Legal Requirements
 ================================
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..eb348cc9588f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -734,6 +734,12 @@ F:	Documentation/filesystems/afs.rst
 F:	fs/afs/
 F:	include/trace/events/afs.h
 
+AGENT RESOURCES
+M:	Sasha Levin <sashal@kernel.org>
+L:	workflows@vger.kernel.org
+S:	Maintained
+F:	agents/
+
 AGPGART DRIVER
 M:	David Airlie <airlied@redhat.com>
 L:	dri-devel@lists.freedesktop.org
-- 
2.53.0

