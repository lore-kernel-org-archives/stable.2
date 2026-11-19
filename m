Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099689;
	b=qkukirITRxD2uyQ5DK/I39EYo7E4fUrUHe9riRLh+U57j6IBiCmCfoKKOU6yS6JypAg1
	 RTJquXpE2Sqmbz6QbdTS56C0mO8y67VSvR/HXEG+caEDqAY2JFJ7ww+m0AMj0+iQpNrsN
	 WF6gPkNKageXIABtiELnFo8ZJY8TCbYxrX7tJ92WBZMg+5REHia3foTEr62xQ+s0EewU0
	 tzoJSvdxO937+AwQEvZdzfgp0Q6gS1J0Ey/CaHhAq3Qov7LaOSA3ZJNwMYlqV+1Xjhfit
	 uAkfLh3F5Duyjkm0ETXFitTqGZ5xNcbBVWqNrm+ECGON7aQIybyk26gwZuj3oRyBYmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099689;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TwK0BYz61Wq22ArIOv16qq8qjStjEa3rU12M8LJ1oIA=;
	b=wiuasMoqgXqmflL2Z4D79GUyp8Subc9FxULUTNYUZu34pfPXW9Ec224PbbwFjtUVY/SS
	 gNS7ExNPwXdvj7wz0f0KzpV0XF0Cr4gkRiOqjHM4tTzMsQKogJesgjoYyHVnQImyaARn6
	 VTlYCrdBUesDcMI9iv8KVM0MuXmi9mAQA7SeN8eAKtiCowTRxqYiYQaMY+5zbPCdvPQ5r
	 WYH/ydVzoNI5Nz0XrD52cPbRROlrP9TjtVfHv1Jb3WzexzWfre96+O7nfHXHK9kaiUEV8
	 yAg6+Mbaaabu8NPjlNvTq5Fx1unbwOJGo9i4dAPHTwIXw5n9GrP0dgQ6mGMO4qTC3iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=b6JIYUiM;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37EC60A6F7E
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A37EC60A6F7E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=b6JIYUiM
Received: from trampoline.thunk.org (pool-173-48-114-214.bstnma.fios.verizon.net [173.48.114.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AJElcJN018032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1795099661; bh=TwK0BYz61Wq22ArIOv16qq8qjStjEa3rU12M8LJ1oIA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=b6JIYUiMufeabNYQDhMPLPClx0cVCjUL1dwYaOryxBfyVtRoJJZaHvOKWtGnVsMmV
	 DI5o3nHEY2BYniE7OUHnVdycHNULYfERoxcGablxsP/XVqdaeGA/ryCS5zkEUm4uxJ
	 axsmBHZXNLes3lucTvfaGrZadE122vYgMWz82nl48keAOCYIhTFUXuCjSD9paqUzRs
	 J1LSsiDRxrdrayTJNsTLcyzvKpBuItS2QDyfbnbVmaJYGa3y4htQmZWG45Ph0d3ylW
	 /+D4wwmX590QWGZYJ1d47Mettj51TL7v0LQjvzbMccmvkfLaAeAbAROyVWS2qYkmi0
	 R4et33CTC29Hw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 1682F2E0160; Thu, 19 Nov 2026 09:47:33 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        stable@vger.kernel.org, Simon Brakhane <simon@brakhane.net>
Subject: Re: [PATCH] ext4: validate inode block references during fast commit replay
Date: Thu, 19 Nov 2026 09:46:57 -0500
Message-ID: <179509948719.1938961.2510357164621183821.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026164853.3125835-1-hamzamahfooz@linux.microsoft.com>
References: <20261026164853.3125835-1-hamzamahfooz@linux.microsoft.com>
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


On Mon, 26 Oct 2026 12:48:53 -0400, Hamza Mahfooz wrote:
> __ext4_iget() currently skips ext4_ext_check_inode() and
> ext4_ind_check_inode() when EXT4_FC_REPLAY is set in s_mount_state.
> As a result, an extent-mapped inode loaded from disk during fast commit
> replay never has its in-inode extent header or root extent entries
> validated before replay paths such as ext4_fc_replay_inode() and
> ext4_fc_replay_add_range() walk or modify i_data[].
> 
> [...]

Applied, thanks!

[1/1] ext4: validate inode block references during fast commit replay
      commit: 7b2eb8a438f6a29aeaf4322657248f21596e04e9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
