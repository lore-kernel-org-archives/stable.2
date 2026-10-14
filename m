Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51ED545294
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996808; cv=none; b=pr9JtXgnQafiqHRKZdB4uWf9Pjq5crVb/MgYhoBdpmEBvlUiwWyayh6pa1LbTHwubwYmgzTMYVx0w2d3PYhKyRCZnrsiwmKM+OeC6XqTUHGfmwDUgZfFyuN8gczMwjD+xHWwfhYw19vbCsep4X4xPsK2AyJatqy9w+by2fxsl4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996808; c=relaxed/simple;
	bh=0hDPMp+3FFaLe+0RG7cBhcdCO6TfAwVsBIV0vLJFuow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrtvQXIPnbegwgGEb4sL2XYQIWlY9hahZbuRuj5z8mqsDG7f8yq1W++qqlZTUsqGZHrzTTi8HDtxo+UqN55VBGuC0c09m8P4hVowjHsQpPVKM/68GyLRNiTkldAgToaJe8fo+goMz8QRnrLqWIZjfGyUDXtrrKQIzjFjbQXs2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmLjYsnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmLjYsnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E471F000C4;
	Wed, 14 Oct 2026 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996807;
	bh=1MkTmDg1xRNZgsmylDqw+2SsXY9f2CaC20wxHQJFG7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QmLjYsnXUr83cLjbiwaMIbEWpJN3EMz0tnburw48umOUrkYfGEK+Bk0SCFe1dPhf5
	 E1alHJwby5nR1D299zyyTmkCbBV2VG4k2iVebzYiAWiuVHWuY+UdPOuFiVMKkYSiY+
	 1Epkt5Ib+pb0SlGodHKx7nLo8FeIh6FSxZ4fhUN2ABJ59P899x7kxkWy5SiVxHUAq7
	 1fCMJWfHeSveGqPur5UfFekPzQ7y7VUBRZpadraUI8PPJrOILjTdWOO8gagjy/bcWV
	 mPoKPCjGfi5daOZCT+PQNqJPuFC9tZWiV6s+we2W1+DTb5mA46YhTHiTxOvxfdRCgt
	 18hul+HKFVFTQ==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [STABLE v5.10] tracing: Set the trace clock before registering the histogram trigger
Date: Wed, 14 Oct 2026 12:53:09 -0400
Message-ID: <2026-10-14-1-daily-reply-0006-tracing-hist-trigger-clock-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014075823.29994-1-lee@kernel.org>
References: <20261014075823.29994-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> hist_register_trigger() puts the trigger on the global named_triggers
> list in cmd_ops->init(), and only then sets the trace clock:

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
