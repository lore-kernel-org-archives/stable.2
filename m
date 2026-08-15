Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8082D46CE
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761212; cv=none; b=S67eYiJKjFTlTTDRLJHku3anuC/ByOKIW9C8vS5rx+eIoWHNScZebhRzQmiktNG8mAispflNC0JIhRkFjCQeMvyfxrogBfRHUmdnHM0q3CQ5F80Vw6za0DBWWZJ7UbShIQ8ks5OvEHr8e+qYmbM3MVsEdqccUrk+8gFASgUoSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761212; c=relaxed/simple;
	bh=D8eZPQun43DdRahUFg7Q/ZAv8Wq1m6xjHpyItEBTPIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D10cyNYsU8BNpnu+jEbeG+0hstePk6oPo1aH4eNEVTIaKcxoon6WIQsON7wYSrn6LvhUUElWlU4ZUQspihVr04nB8JAH0JdEKGvXK6+cpvJVsopz7rlncEDrti6WUSAFenHf8ihQeGPqDlKenv0QroVlpgGdZ1VB8BemB0bUSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luQlRJl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luQlRJl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1495F1F00A3D;
	Sat, 15 Aug 2026 02:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761211;
	bh=FnX66o4my3DM0vm0XApR/7JiwHy3TsbPI/12ciU8cSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=luQlRJl684JOVenLGaBdjvnA1XgTVMJXNt17Xmi6lFGXhPurZMxyMeBZV5fxpYpps
	 rPDiNPejXmJ8PwLqclu9VjUt55IZEnBnZoq5R9rUn5I5r+loHFBq1yaELS347Cse8c
	 bKyMJHJ1FPjmUKZlrkSMjbzjlxyrLCeoX2YiWEYUhJad2lqQlCgkIW5dvpUorxtCyl
	 R9uYwWuajib0hJYz4jN8HHTJVZRxhkdwYzb2JD20DiA65GmtLbvFRyE6fqjTH0sIb+
	 vzxYaCzf/lmnCbOD6zRpWcZHYO6f9rW1QawQUV3TV+elZzm8VwfiiVUat7nO5l8T+e
	 zBRZkcEU+Z/oQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	alifm@linux.ibm.com
Subject: Re: [PATCH v3 stable 6.6 0/4] s390 KVM PCI backports for 6.6
Date: Fri, 14 Aug 2026 22:33:06 -0400
Message-ID: <20260814193000.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812212403.3143-1-alifm@linux.ibm.com>
References: <20260812212403.3143-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patchset backports the failed commits to stable-6.6. I have resolved
> the merge conflicts and tested them on s390.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
