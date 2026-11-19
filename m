Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099689;
	b=LERgkxiTPSqDrXmkFl7N0O3Ej7DPd0ItWazDM7b0X7g6IPxBYxorBC6MskQrKfSJ9nsK
	 OG1AirEDQtrFxwcSnrm6ZNQlhXGJEHCc/MWwIzd9+5REykpdPLVlG/CmR/1y/zdN8xcIB
	 3VXgkYe7fvGwCLiymKZ6yE5zheXOuVlhgTd3t7sKuxETHKwr8ry9dCyhCoRO0+9cJVPWb
	 ynf7zZN5WgRHTNsuPrMkP8Kp/a8fCsmBvUA1RIeLmKgiK/qEDtkFZDWlzk/Z0do3Tmlig
	 evXxnZhjiLABmS6ZBqrzsbpHafx5b2kC0UlX9WL0F2eaaWiMhjQP6+G9+PKF/SeoQIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099689;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=lWeQgtgDJwbBg/BsxMcBjy/M0Lhogktk4BofIp939h8=;
	b=lrjJCLOdRYrXYnjJ+0dHUp80FqHbNQWCnLVliNHIhvwQFrSIEgxFCd7zZmaW4f1AWKlh
	 zQ2JKAQAt8LqtZIlQl+rMdi4J+BrIKR2OPPIFnIAFuvrySk5Ai831J1ptWUsO159U1qWo
	 FpHhpuSPy1LQrJxjlCL2CRo5qsNuYC4v/oUyNX37qTdUaGfMMiy99W5vBZWAhe9/ZKqDm
	 sopTJ1kG/3HO435GBoOGEZN7weHdLOEV7G7RSdMBIOGfZJsoxo24JBLdlGAxzNl8Bzudd
	 8NJHaEzh/ZAR7pXvGbucF61SE4fmeDt4xD1SBXlB8qE2Xozxw4+FaC+YtL1ca514NOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=IvXE9qlx;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1C606E898
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B1C606E898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=IvXE9qlx
Received: from trampoline.thunk.org (pool-173-48-114-214.bstnma.fios.verizon.net [173.48.114.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AJElWx6017794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1795099656; bh=lWeQgtgDJwbBg/BsxMcBjy/M0Lhogktk4BofIp939h8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=IvXE9qlxjkbZQjzeF6wPsg9yrkpoLl7uoCyfOIr/V7e9/imgEPpK/B5kPz9+6VYtM
	 A6AH92n9hY3n7ojzG8BOCnrFxbT3KzQcS/Hg6ZXb4JTSpG8SKPmLNpwCaF5ETrcfBm
	 YgopviEUrTWxy3TXBQgr6WyHQH09fThoK0gRUlAUHRUBXAw++SwTSjWTZaZWkdQs43
	 QU+Z41UzxyLzq1P8vDPGEOX0yOqEwF8+RotD/rBBWWS7eYi1yY6DIskdSlgDlbA3HD
	 HQB7mF5hKOjR3oQoFETjMbSXz/3OtR0TIbE8XoqyeBEFqJO95Q0sgajNeH3rF5w/L8
	 ItLHdEI2bc/SA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BB5C62E0146; Thu, 19 Nov 2026 09:47:32 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>, 781735889@qq.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        libaokun@linux.alibaba.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, yi.zhang@huawei.com,
        harshadshirwadkar@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: propagate errors from fast commit block cleanup
Date: Thu, 19 Nov 2026 09:46:34 -0500
Message-ID: <179509948676.1938961.8959466252956092980.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_FBD69AA6034FE7AF98BC3B90CB1EF012C106@qq.com>
References: <tencent_FBD69AA6034FE7AF98BC3B90CB1EF012C106@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 15 Sep 2026 09:58:28 +0800, 781735889@qq.com wrote:
> ext4_ext_clear_bb() stops scanning when ext4_map_blocks() fails, but it
> returns success to its caller. It also ignores failures from extent lookup
> and replay-region allocation. ext4_fc_replay_inode() ignores the helper
> result and continues replay with stale block bitmap accounting.
> 
> Propagate all cleanup errors from ext4_ext_clear_bb() and abort inode
> replay when cleanup fails.
> 
> [...]

Applied, thanks!

[1/1] ext4: propagate errors from fast commit block cleanup
      commit: 50c68d7312e0c5a34ac6dcc74f15aeb18d0f0146

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
