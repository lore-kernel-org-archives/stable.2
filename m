Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799114AB3C0;
	Wed, 14 Oct 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017213; cv=none; b=ntbFVXQOVG3XIr2zYvOubaQxGMvC0Peg9VHN4utP6M9VJZn0k6BwRzM9HxTswV5P+4FWm/S4MGmm3mWYRbmUqGnLShdWHvu794A51f1287qMz9KJMDzto62l6gjp2PjgPn+cOe4ZaQkKV9AGBE9qcqadQHxvIjZJ1PQZEIROL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017213; c=relaxed/simple;
	bh=flEBA/XREmCt7HtumS3yMrWp46sFqNpzX6s6ENVH0Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwOvp3d2Uuw7kpxEMCsWtKHdmon1awGFILFB4a8Rj1y/0bVWUOtPQLn9I+UxA82kML4AcIyYRJEK7qh+9U6A/kh71BbXQeUMdRoLH6SByYsTLLh0QiSUi6U2vnLaiA4OPS9sf+RpqZ8n1m8RcTV8sBl+hpdUYnU/MrGsfOViKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InGe4e07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InGe4e07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498441F000C6;
	Wed, 14 Oct 2026 22:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792017212;
	bh=oITed+1J7zs0+HkBZdD4eaEi/kUeu+yJJvY/jlDeIPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=InGe4e07/U3ivi0DVfcYNk4VDUHQtXaotlygRQoDHh4nHMqfoJqBsVef9FjKlWFC2
	 NIf2F4fpFXA8DD8GDzqZz6FQkM14hGGzRiLiYIRhN285lsl4oJEXWn0U7vYjQuRxvs
	 Cvv8XsyvJzSX+2ap2wKfmc8r/cOwIqt+mfkr1x21f61tD/5C0jYA9HH3u5+hwRuwSn
	 1y5w/AHR0pGFpSY117/Uiu6NIgusuxUCpO5LYfcQ3QQByCf/c2JkMapCm6pqSoXLZ/
	 jVzVsVxYPgJop608f1Xo+tWm5YWHmWHh8OCtk3YcYPJumJ0wnVArlpaq+iTNJLURii
	 k6vNdKmfKnUOg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	kartikey406@gmail.com,
	harshit.m.mogalapalli@oracle.com,
	johannes@sipsolutions.net
Cc: Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH v3 6.6.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Wed, 14 Oct 2026 18:33:24 -0400
Message-ID: <20261014213019.rc-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013102041.2113948-1-guanwentao@uniontech.com>
References: <20261013102041.2113948-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 06:20:39PM +0800, Wentao Guan wrote:
> This is a fix for stable v6.6.158 backport commit, so no upstream commit.

Thanks, v3 has been queued for 6.6 in place of the earlier version.

-- 
Thanks,
Sasha
