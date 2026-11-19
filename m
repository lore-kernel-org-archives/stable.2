Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099702;
	b=wJ/PAMRabVQDhMy/DSpXYTrznvIaLJw9UbnK8keji/MxrJR6rh7Ho8ESFGsGKz689Mov
	 Jv0+sHfeOknXHYttUQuBegSUtS45wFevs2Up99/yl1/eFCVtlSIlqCFvrq1TwuDacotYQ
	 U8+/sT8tsv1BGi2Nq1eSEb+GsfI5Yg5cjvkXfZJk5HNJkFXsoQxIsRu3aDKQb53mtRbcf
	 qQk/Nj+XtSovzSRQFeLq9+QBmvQWAxqCgSmd9+6nQuX8cI36E2dnOiJy3Z6XJK27/SPO0
	 BbjKQEarltVH0GseRwzAKHGwrPCz29EEQwHrCwp4QFAi3tfIiwX8ohLxl4T23+XNHKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099702;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=CJs5Fh4um+VOO8yp3KmSCoi3cKkdZtaS8fsDg5qtaHs=;
	b=pmHerbKItv6f1dUxv+fT87kFr/mZP9DAwWCuOCbeNlK7gwq0Rxcd7ki3DWrMD7oC0eeb
	 WdZcQx2aca7iKzlb9XYsMFxWw61u3reRBLMnS2RY2R5ZhK7Y9tCmKikNs5Fs7XtUqHZpW
	 hTXn40v9zqpMLxDPmSO3Yx3J3V+MamH0IRI4sjLkOMRio/JgOKfKDlpTeCEy46EJQmmOt
	 cJN3OCLk53F1yQC/i+bLcdjB1Vsmc1ULhFhO/OhfsdqnuDZycSG+qN5yc4Y39i8iWAULJ
	 S8czai5CGFXLKmT8TLmyX73W7woJr41UIRtz3z8FmtsJBvEetT9/k2/jxO+fS3nEbKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=a6pEG0IR;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEA60A382D
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80CEA60A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=a6pEG0IR
Received: from trampoline.thunk.org (pool-173-48-114-214.bstnma.fios.verizon.net [173.48.114.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AJElfHx018182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1795099663; bh=CJs5Fh4um+VOO8yp3KmSCoi3cKkdZtaS8fsDg5qtaHs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=a6pEG0IR28nF1W4KrWGIqFFcZOLfgDi38xeUtDxn4AlPwtMDe+CMYId0QMr6+6GAJ
	 t3wumSUgmLHWIybYiwqDV9mi3HzEiB1VIM/G4/Rz5d+slDDQitO9KPpqhQ8/HwNaGM
	 VmRzlv2hB/vlcwP/DmB5UJmJ3DuavfSM6Mf4vaHK8XBTHQ5sHbBNuIELF9ZTa3S2Bn
	 DWrJUtyPfFBExd0XTeOXp2mmvG1CU4FYuTcJGrLnWKCLc3XE1wfBo7gHu8ZfmhPZrc
	 7eUvbaxs8L0iVNbSqrN1fBMQE/xjNyM2SqHTqkXxSFRurNq2EoXhB5pTYJb12zwjaj
	 fbAOSgR2vfRfw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 5501E2E0192; Thu, 19 Nov 2026 09:47:33 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, Qiliang Yuan <odys.yuan@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ext4: fix shrinker scan budget accounting, plus a related cleanup
Date: Thu, 19 Nov 2026 09:47:15 -0500
Message-ID: <179509948691.1938961.10329676328221877211.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001-fix-ext4-es-scan-nr-scanned-v4-0-b13703714ce2@gmail.com>
References: <20261001-fix-ext4-es-scan-nr-scanned-v4-0-b13703714ce2@gmail.com>
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


On Thu, 01 Oct 2026 15:43:55 +0800, Qiliang Yuan wrote:
> This reverts the v3 simplification of the ext4_es_scan() shrinker
> scan-budget fix, keeping the unrelated locked_ei cleanup from v3.
> 
> Patch 1 keys SHRINK_STOP off nr_scanned (extents actually examined)
> again instead of nr_shrunk (extents actually freed). Jan Kara pointed
> out that a batch finding every extent still referenced and freeing
> none of it is still real, useful aging progress, not "nothing left to
> reclaim"; Sashiko AI review independently flagged the same issue.
> This restores Jan Kara's v1 Reviewed-by: the diff in ext4_es_scan()
> and __es_shrink() is unchanged from what he reviewed there (only the
> explanatory comment reads differently).
> 
> [...]

Applied, thanks!

[1/2] ext4: fix shrinker scan budget accounting in ext4_es_scan()
      commit: ec14be6c39ceb7abc63d1d9ed61f35bf7f45055c
[2/2] ext4: remove unused locked_ei parameter from __es_shrink()
      commit: 96b04aafcf777c0f616ff44a7d9cabd4f4551529

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
