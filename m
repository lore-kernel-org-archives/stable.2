Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5723655EC;
	Sat,  1 Aug 2026 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622419; cv=none; b=g11GT0MAArRUi+0vBVbwXQX+sWgBUWmKaIFcHWnA72O+P2zsCiB5Kjwn+l+07B8ILkLCSBn3RwDGQG0BGKN6XnJFsNMv0iJ1hzHnxP5yppKvXe4hebitNYVr+r70+6LWtatgkMHJYE7CGMSWR6KexgnkEsg/PsnRio16j3aktWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622419; c=relaxed/simple;
	bh=fwgXVMk4vM3Z1ibV9di+iz8fOjmQNhv+OTYHC4+MM3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anVRfybeOp7dCSkXgYmn29ZGsMGdUQdEihq3Yhjh2kLfxwqq3EJUaIhIlnAkI9qtD3fXYa4AoPS+pq9nO23IhNUC9+Gvc3/tmxvrRf4FhFLeUGi9uu1rzvA/h+sINlEnhY1Ps2QWQC6kH07GcQUVihcVRbrKUpW7dnNkkTry57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKtsdsRm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKtsdsRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188131F00ACF;
	Sat,  1 Aug 2026 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785622417;
	bh=CyDsrvNet7g8tbmalZTteNPizo/JdUyMnOWHyaWxUNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KKtsdsRmnhDpHMWlJMcjjQV5Vsmw1dp6oYxA225pZs22t/jcGs3Px3676w/wD8mKM
	 IUQ/rtDbMO+E1Sz+Z2QHlUKBrHYETTvdV9l1lYFIbYj11q8bp4d4AIiA7VhIR8KrQO
	 ReKdsyUNfksD8O/zyQMKopEf57P6R5mzYAqvMUn97zCZprp+AMK/f/wBe0jSrgge7B
	 YXt3K41QRNwb73itDrCbOROxyEwGbtbemhNaplBTOnrIU7uvwyKmD32zYczv5nO48J
	 EDF3ypwAZIPbNtSu2AKOxSJMpoADGyR+vyHc7f4tMdvqc0bVWRqO7a+XQw2MFRbf7p
	 mj9kRL1feqslA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	Michael Diesen <michael.diesen@posteo.de>
Subject: Re: Please apply bed0c8084044 to 7.1.y and 6.18.y
Date: Sat,  1 Aug 2026 18:13:27 -0400
Message-ID: <20260801154223.stable-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4391ca99e19df478490aacfcde6e5ca4@posteo.de>
References: <4391ca99e19df478490aacfcde6e5ca4@posteo.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 08:50:28PM +0000, Michael Diesen wrote:
> please consider picking up the following mainline commit for the 7.1.y
> and 6.18.y stable trees:
>
>   bed0c8084044 ("ALSA: hda/realtek: Add quirk for HP Dragonfly Folio G3
>   2-in-1 (103c:8a05)")
>
> I forgot to add a Cc: stable tag when I submitted it.

Queued for 7.1 and 6.18, thanks.

6.18 was missing the earlier 103c:8a06 Dragonfly Folio quirk that this
entry sorts next to, so that one went in ahead of it.

-- 
Thanks,
Sasha
