Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148E24A06D;
	Sun,  4 Oct 2026 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791142440; cv=none; b=FoZyW11JWCGyuOoZQKlcp0jXYAzgz9UlV/n6HiuaL6pRAR+n2+/eRyc1f3snMQ64Oqnw42iVOTOo2vZGPC7WQxxZ++Cy6BNsPSxYxEwEkjacRfpWtOL+Zai5BfDnDnD1vMV67DxxymZWy3Sd2aIxvOQDvBKtJRAs9xn89zxEgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791142440; c=relaxed/simple;
	bh=+2FGiViRGPFUfc7WUiRJ4xJB0c9wttDwF61j/d0NFuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SoTjXTg5nvkAD3lusXIBwUpbDxDBCb5LjKYs1jEihBro/qT0wjl7rfXYi/uV+ljTUz7tXn8Ypu8sEICMyeZSt9y9reDwq5dyDqJJUqG2QBeKQe3Hn0ALmlkiQqq+m9uN3PCegXv53rw5fcu4J/SrB//+/Pk9Yb2y8vPNxwwVHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EF61F00893;
	Sun,  4 Oct 2026 19:33:58 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id CD528180B21; Sun, 04 Oct 2026 21:33:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
Subject: Re: [PATCH 00/15] power: supply: Fix AB8500 and AB8505 charging
Message-Id: <179114243483.217534.9005482513094826920.b4-ty@b4>
Date: Sun, 04 Oct 2026 21:33:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Wed, 16 Sep 2026 08:49:22 +0200, Linus Walleij wrote:
> This series first fix two serious bugs in the AB8500/AB8505 charging
> code making the charging report bad figures. (It only affects the
> human-visible status, the charging itself is safe.) These two patches
> are tagged for stable.
> 
> The series then audits the AB8500 and AB8505 battery-charging stack
> against the revision 3 hardware manuals.
> 
> [...]

Applied, thanks!

[01/15] power: supply: ab8500_fg: Accept status from supplied power
        commit: 16f506a13b58a55308449bbcbec89c817d619ca2
[02/15] power: supply: ab8500_fg: Report sub-percent charge changes
        commit: 4d40dba1815d46c6ef9019ed80e3b998b0fc443d
[03/15] power: supply: ab8500: Correct register definitions
        commit: b4d3dc743df09cf467271e1490963ed9699ddfa1
[04/15] power: supply: ab8500_fg: Drop nonexistent AB8505 controls
        commit: 0bc9adf42698de962e845a9355b53bdbee5b5895
[05/15] power: supply: ab8500_btemp: Fix event temperature reporting
        commit: 95990cda8e42dda4bd3f1475d578323981bd8579
[06/15] power: supply: ab8500: Preserve battery termination current
        commit: 3b33eda4067494658d51db0792377fef98787e3f
[07/15] power: supply: ab8500_charger: Fix AC charger re-enable
        commit: 3e1d2517347f6bb72f74e63ec77d1634385fbf21
[08/15] power: supply: ab8500_charger: Decode AB8505 USB status
        commit: 2b697df2b6394613a3bb168adfa8a845ad7c83d9
[09/15] power: supply: ab8500_charger: Respect AB8505 register layout
        commit: dcecf527632297011153f088573689a1ad1de790
[10/15] power: supply: ab8500_charger: Handle detection errors
        commit: 1098c619ce7595a77a8c2e366a703e9fc5f29bf7
[11/15] power: supply: ab8500_charger: Skip absent AB8505 main charger
        commit: 52c8cdcc1146d86fae524a589d4512c8d59ea8b4
[12/15] power: supply: ab8500_charger: Retry AB8505 USB detection
        commit: 95fba2e3055df99ed19e7d6399101bac42b3e7d5
[13/15] power: supply: ab8500_charger: Recover inactive AB8505 charger
        commit: 76bdf9d78245bb068207c23e9bf43d4b9bb201c3
[14/15] power: supply: ab8500_fg: Finalize current measurements
        commit: 9a0461fb5e7cc64ed303bee3661452879ee139a1
[15/15] power: supply: ab8500_fg: Avoid reserved AB8505 CCConf bit
        commit: edafb2e4642b72b0f86ce5990d5c29c116bb642b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

