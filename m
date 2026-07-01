Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC722AE65;
	Wed,  1 Jul 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913708; cv=none; b=bnbEffxp0LA4RTdmRsHOqLrC439kVAf3q04vY9Yy5CsEnr+HE2gpNSt6hiv+29uGKIrZIOyGzRWBAzPVQGqgGxe0tVmb0ocpYGTIUmobVhRd5FxZdaa5lBm4/Ebdd8zsDa1dqbFzewgvwB+mSvB2G8sPFb4svn/P4fKbQgGaPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913708; c=relaxed/simple;
	bh=0aF0k3dCXbDs8EWzDI+K1JXtdj6+IiLNyBGGmcZ1U/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqn6cd48QF5nLEIovsdw1NhI6GZPgV37vB57a7ccB/LBir44TFFDGvBEgSnTGT3Pldt3kF9pzsdcCOZV734qA0IfBO6DVCuq5JaQ3lGIvDZXlCvHeQ+0DvK8kFu6UJOrIqs5k5vETCjzrvRYvAmuM+6FME8P4KspCq1cysRyyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/vNQLW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/vNQLW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA31F1F000E9;
	Wed,  1 Jul 2026 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782913707;
	bh=77oBzAV2L9TMXx/bROM6lzOXrpNGNQibPHkuk2PAc5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f/vNQLW8ImL4jHyjGc8nEK6bGmRZFup8Jt35n8uPPAo733kpsB+g//kU0VwI4IRJz
	 H/aA6pzVHbubiCMYOiYOygF9QbBkcXvmsgwkdY8s/0KKUojafMTNChZAe6xb7g4mUi
	 ARdTZH/zPBnd3w2LQYfHNaY9qPewv9ltfU6nkg50=
Date: Wed, 1 Jul 2026 15:48:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jiajia Liu <liujiajia@kylinos.cn>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] wifi: mt76: add wcid publish check in mt76_sta_add
Message-ID: <2026070127-footnote-usher-160d@gregkh>
References: <20260528033814.46418-1-liujiajia@kylinos.cn>
 <b143b62e-ca11-4f00-ad60-f71ae55213b9@leemhuis.info>
 <akSoHk-BozrpWPmZ@nature>
 <dc7657b2-e3d5-4777-af52-1169fe743761@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc7657b2-e3d5-4777-af52-1169fe743761@leemhuis.info>

On Wed, Jul 01, 2026 at 08:16:07AM +0200, Thorsten Leemhuis wrote:
> On 7/1/26 07:39, Jiajia Liu wrote:
> > On Tue, Jun 30, 2026 at 01:29:51PM +0200, Thorsten Leemhuis wrote:
> >> On 5/28/26 05:38, Jiajia Liu wrote:
> >>> Since mt7925_mac_sta_add publishes wcid, add publish check in mt76_sta_add
> >>> to avoid reinitializing the wcid->poll_list.
> >>>
> >>> Found dev->sta_poll_list corruption when using mt7925 and 7.1-rc4.
> >>
> >> Jiajia Liu, Felox:
> 
> BTW: @Felix, sorry for the typo!
> 
> >> given that the problem seems to be in 7.1, should we
> >> ask the stable team to pick this regression fix up, as this change was
> >> mainlined (as 20b126920a259d ("wifi: mt76: add wcid publish check in
> >> mt76_sta_add") [v7.2-rc1]), but lacks both a Fixes and a Stable tag?
> > 
> > Yes. It seems to be related to cbf5e61da660 ("wifi: mt76: initialize
> > more wcid fields mt76_wcid_init") [v6.14-rc1]. But I didn't reproduce
> > when I checked it out and tested. So Fixes was not added.
> 
> In that case:
> 
> @Stable team, you you please pick up 20b126920a259d ("wifi: mt76: add
> wcid publish check in mt76_sta_add") [v7.2-rc1] for 7.1? It lacks a
> fixes tag and the problem might be older, but I saw two reports about
> this with 7.1-rc -- so it seems some recent change made that problem
> more likely to occur, so it might be good to fix it at least in 7.1.y.

Now queued up for 6.18.y and 7.1.y, thanks.

greg k-h
