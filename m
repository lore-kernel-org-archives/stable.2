Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1009C25524C;
	Mon, 28 Sep 2026 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599188; cv=none; b=Ll/9XLwqJn8cNbXR48RuEOvrTwBFE3lrycBvo01Eqy3JUDGe2BBxSaclJcDf40BLUH+ixnc0hzeM6IKs48CcXLzfUahO6jcaGxEsCkiAUen9mlBlg/yTa4MlcEy6Z/bYohgspoNBbo/DapdH81LXR1cpEWKZ/lOtT1SkBtvHdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599188; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LyESqKw1vyOv8cDjGqMvCzQLUpsxebyQHenZeHr5cHZLV9Z71shQWgc3IuJOrUDJho866p5Z63ffQZZm+ZQvn8E+sqfbVfYPy0WyD1565+Fmt7FM+Vn2sPrjFC9rHD8BoqWmt8pyscyyKocWIHTq/x/FV4xD2VZGM/F8YhILuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmyQ60dA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmyQ60dA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AAE1F000FF;
	Mon, 28 Sep 2026 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790599186;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PmyQ60dAkt/uD6wyBgDRM3UFCZTVBM3auopW0Vp6w82r2+mmj8AAcRkDe6Y96e/8m
	 eZ/jw6skaHjL6fpi5c2clwFEM7B6OBaeAE7CKT1nH/YRE6or8vgIaE5KxUBHZoEOGt
	 cmWbNwz+wXfvVyXkY1UUYdLjBejJZ8DQ5XKWhBj1L9AYRhFTuUd6hKTbW6ftQM0Nbr
	 3Edu6LYGs3v5a8LJjOwU8BpiuIf7IKLbrqU0bQLx7ZleDB/XE1oLaR/n2hbkanuKH7
	 zwi1Q3bV1oW1Udhrc3tpCRMIFBdK0aMKQLRi+Qh7+A3eCyxN7+P9UxNT4Mh5IzGz9h
	 ukzKRYdQsqzYQ==
From: netdev-bot+sinfo@kernel.org
To: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v5] net: e1000: fix warning in iounmap on probe failure
Date: Mon, 28 Sep 2026 12:39:45 +0000
Message-ID: <179059918543.31693.4938540014506455007@kernel.org>
In-Reply-To: <20260928123814.2605-1-nsvatoslav515@gmail.com>
References: <20260928123814.2605-1-nsvatoslav515@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
