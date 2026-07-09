Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1238C2DE;
	Thu,  9 Jul 2026 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559093; cv=none; b=nHocFb4OLO4uh57K0p2qs1QX6QBcDK7npoUNg+aG1VU6o3jgOwEoJ5MO0oTDeXaeqR+FCRv4mZElA81JUl23z6U244/jO/RMIF+v1e69ijrkXAKnM7cNLsrFVY8Spn/6ff+myDW1hslOgRbZalNurIURGbQPJkDIWdzpMepuHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559093; c=relaxed/simple;
	bh=xUs4wAy8JUb9Ic57L2kyMPNp79QTUf3tscDEOPv85gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAeU1iEccFim8Pxg9PPZn08G/9kyr8hz0mZmk4myo19/EFHRjps3BnifmZOzOQ44el84GK9JSOPBweOKFIwC7i9RdIsgh7AVkFAsx/YBFnrW55WYgk+XWYKXM9ur60kYhD4VsLCcZDApqPaci79lajfUK39ddFXdTua6an056bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjuP8cpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjuP8cpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6D11F000E9;
	Thu,  9 Jul 2026 01:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559092;
	bh=PsqFAtt/QiPLYAvf8WoanRCKQA0mCWJzQjJEyhGxIcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjuP8cpz615bGCqS+Wx3a0DcogUkF5ac0TPjrNtqEGVxCpXY+bn84IZnWHWoSD6fL
	 j4pp5YtbUuU1kQuF9obftZAeuGSgSGPvp9GI+l6Som8b7xOj0qUqTLQcCuo4+WCBzz
	 /aoVzB4ZXA3L/Siy7wkXtyE5OzJCljP5HyDlo1nV6+rAT6OZOCRgDYSyAf3lR3bu0o
	 SBqECDV1XzSFh5h6q4Uh5qBwTKUeXnCo9kcwjTS6GOUKlHa7i9TYauQeT/0ZYtM4j/
	 XgPnYJquOUx7m/CwR9CMt1+3UwXTtuWfwwuRB5tLA1/IfGjsKPY81UvZBf4kFcdYh0
	 ez1Ar1fDEP3jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jeremy Erazo (Devel Group)" <mendozayt13@gmail.com>
Subject: Re: [PATCH v2 0/2] Bluetooth: ISO: backport missed OOB write fix to 6.6.y and 6.1.y
Date: Wed,  8 Jul 2026 21:04:45 -0400
Message-ID: <20260708194323.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707220526.271712-1-mendozayt13@gmail.com>
References: <20260707220526.271712-1-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Root cause: upstream commit f4da3ee15de9944482382181329bb6d7335ca003
> ("Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID",
> 2023-09-28, mainline v6.7) addressed the OOB write in iso_connect_ind()
> but landed without a Fixes: tag, so the stable autoselect bot never
> picked it up.

The upstream commit cherry-picks cleanly onto both trees, so I've queued
f4da3ee15de994 directly for 6.6 and 6.1 instead of the v2 patches. That
keeps the eir.h include placement identical to upstream (addressing
Greg's review) and also carries the getsockopt put_user() hunk as part
of the original commit. No need for a v3.

-- 
Thanks,
Sasha
