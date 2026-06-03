Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB33D16EB;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519623; cv=none; b=a/rlqr4G2D6tf3C5BfgHXwKN4CLNNz8PynWEQaKioQS8odnXUSuYOuukcxLCbQPV5wyYzrM9Zl+F2+jjC9f/Otl4sJBemx/Gc+bWnl01d2SAuT5O+2yHpzdjVjLYjDjnGZqPMxTDjzdyxgmtO1qZVQcGAJCO92uvDLI7HYEbbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519623; c=relaxed/simple;
	bh=chZby+AxiDQtNZwdRA6tTlO83+D1yOnB3uueyicfC+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ay46UmnZY/q3oskFPgdmSG8HpaaAG0DWrXiiDjvTfW65+rfXCTsa5Ef0Dze50TGrplHZEciUMe+YISO+dTiIopmWnYyguYkN7ESGnyCQY7Pv71GwK/UVxrRHg332Z/z3pWr1BUn4bIj5296IlFZMx0j8WkZ4f9/A8huTnQi4Xrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9E81F0089A;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D116B18261A; Wed, 03 Jun 2026 22:46:59 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260407073025.271865-1-vulab@iscas.ac.cn>
References: <20260407073025.271865-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] power: reset: linkstation-poweroff: fix use-after-free
 in the linkstation_poweroff_init()
Message-Id: <178051961984.2666348.12784021615069579744.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 22:46:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 07 Apr 2026 07:30:25 +0000, Wentao Liang wrote:
> Move of_node_put(dn) after the of_match_node() call, which still needs
> the node pointer. The node reference is correctly released after use.
> 
> 

Applied, thanks!

[1/1] power: reset: linkstation-poweroff: fix use-after-free in the linkstation_poweroff_init()
      commit: 8eec545cde69e46e9a1d2b7d915ce4f5df85b3bd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

