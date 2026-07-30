Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9856344036
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379246; cv=none; b=cuqWOKKEAvI2vPQRGt+6C+AqIVCHSiB2sKbi2VgHMUzOFVzJiPMGZN62tSt9QkjByjyjsa4GvtK5QPJsTjoeJskB+fIv8kfi8QfTOlGjWv4/F/rrEZ3dIHwK+/bJAXiuCyOSKnI4pAWWNeDStdg5FF8Dai1624q+mRsNK4Ct2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379246; c=relaxed/simple;
	bh=gvjZwDK3vk9fvi1mhI2gcZNkDym7HdHOIKB2adUaltQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn6qqLBOLt/CSfT2Z7KMxkc7wzODVhlzog4tllqa3EXmYUVgQezmP5SB3T2m9tiKGdW5qNzRUNp49NPcXniQGhobB3IW3Qo03rGQ2HMFPG9bvWIHbrZdUUG//aoswBpQTh6AF23jzxNNGchuu8c9FostbFY7UAX5XkDnRblDqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ9Fn3Wn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ9Fn3Wn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D423D1F00A3E;
	Thu, 30 Jul 2026 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379245;
	bh=TPS2Rgv1M1H3WAsvFBhW6WJ1gpXvot38ODtl+rQR6UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZ9Fn3WnX2is3pBsYdvrY9LKdsjSKuvFBSqLV18WQXzSVsitKkLtMhksVahFSFmG6
	 bZUUqFPo4I2orvBmaE/X7p1NrbIMS5wFzNb8+SHCfJupDGinijgXQDq+IvE+8nzuVo
	 F8zTL+tSu6dBDE9FovEJPmgbuH40gUvkn0vr17notRd3w+XNlHJUI4TNP6gR/WTvR3
	 RmagivNMpifu93mKzzn3EjIkUV2s1oeghgdaXV2bkbMihx1dXE1wUvvMTC2jGjXAbf
	 3qJXfLJcg9emikw/ul/3w9prfOy+XE6Q37aiV25OkR8Sy9j5VVYOLN7zuWyl6o2KR2
	 McEexBDDKrc8Q==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com,
	Haofeng Li <lihaofeng@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: Re: [PATCH 7.1.y 1/2] ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl
Date: Wed, 29 Jul 2026 22:40:11 -0400
Message-ID: <20260729223316.stable-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729162254.2169992-1-guanwentao@uniontech.com>
References: <20260729162254.2169992-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 7.1.y 1/2] ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl

I skipped this one in favour of your later v3 series, which covers 7.1 as
well and adds the other two hardening commits.  Nothing to resend here.

-- 
Thanks,
Sasha
