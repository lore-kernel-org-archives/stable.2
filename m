Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C53876BB
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552020; cv=none; b=uoBdePgE8scOJwFgJx4+idVWFccf1nYnLSntBOlpT89HKQRikmNTGvPfsw8gSgpFNZIaBXOemC8Rarmmsbt0luFqhofroq7cnv/H3lXuGuU0WRDoHb/twi+PeD9IubR2wST7tNcagw5yZUfemS8pJySOgFNzSMEcQQ8rgK306+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552020; c=relaxed/simple;
	bh=NrD+MZpLNUNxqF8ZthiJfZDl5vGlCYGGdxEq9Q04fl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHw/D6v4/3iVkxMLNzpGkz2KcAY7B3ZavGXEw1a/feBz0bGBKjtEHx7SqrE4KZlHcOeOAvLAoeYx46UbmczBb7JiO0WfgjEmOIoGjPYliA9UvSnkfcI7ENTlWVYJVqCGbCKcTRiSSMiiBD5muIlQqBbuFbCFxSuzV+j73N5fD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3XpToSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3XpToSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31641F00A3D;
	Wed, 12 Aug 2026 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552019;
	bh=Xe9qGoBRD1g4sMPLXUP4mYl14EmntXlGlCwVdBdSZK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y3XpToShw8ZzsIIbt+Wnh83ap+pKBBaw1gPNYY2CArmEYe9O8UbykF48UCDdWW2wM
	 ZMasO1i18q3madKnuZ6iL6lbWNjKunskLRc3voorBykJT3gxdkg54+jjsSDUUYSwnO
	 ITw0VlpIwGWHEf3JIiN2louvur+eXwFi8/Yu8rbIz2vlCWs/+WXwrRYZXkHLEU0z08
	 Tn84bVkyvL5TNIAUn6cMz9wNy9rtge8OdJNfEB79c0BlJSuNTperI+f8xsX3KFBnXW
	 cP5ymfgWhX6yGxFjZBCzSaOx9e9CbNJ4vBWEeh13NoA3VQOmiM3kZa4ltvPdcaIT8R
	 B0bzyFlvmFZ1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	huangzjsmile@gmail.com,
	Chris Li <chrisl@kernel.org>,
	Guillaume Morin <guillaume@morinfr.org>
Subject: Re: [PATCH 6.12.y] swapfile: call cond_resched() before locking si->lock
Date: Wed, 12 Aug 2026 12:26:45 -0400
Message-ID: <20260812161500.10008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <anw0I3HwhISAvVt2@bender.morinfr.org>
References: <anw0I3HwhISAvVt2@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 12, 2026 at 10:51:47AM +0200, Guillaume Morin wrote:
> The 6.12 backport of commit 66366d291f66 ("mm/swap: add cond_resched()
> in swap_reclaim_full_clusters to prevent softlockup"),
> added a cond_resched() after locking si->lock. Move cond_resched()
> before spin_lock().

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
