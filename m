Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29727A916
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807445; cv=none; b=hLA1YnwVf72nBQqPny7VMlqYA6F5NebHQKZ2h2lN72JCe8MUmiLgs4xbMhNz6HNKWOK5jkb9JM40MyPKzTr53891t1TXjk6CEvRIoJ3NhMCq9r9ql4fNHGvDHiq6f0sYtBA+S4DiBD/j0kryWNyDt0Br60UWn4bfiIiToOeyepg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807445; c=relaxed/simple;
	bh=yeDeV28S3v7B6V9tk/ojACStlIjjWAgekxdrXg8ZHM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tq43N6MyWSbI3vAelB+apIszT1309+OsM81mewep1C5HbKT7pFU9W4YLgMe+jrJ5YoK4bfxdGCLKvtVED5joDdQ4RZDbWu2cRWr5XPAyfaQsAEdBu9QCxJZ02W9zA0uqt9E5g7ZYZ+kPdJdVUUNIJRrdqM2a2lggn24tiGWAmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xBE5/53E; arc=none smtp.client-ip=91.218.175.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xBE5/53E"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yeDeV28S3v7B6V9tk/ojACStlIjjWAgekxdrXg8ZHM8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787807440; v=1; x=1788412240;
 b=xBE5/53E9sb5fFBcFEL5npSNud+LpH9kqJDljiYTof9/UfJbLNwLCgByxuhK+qmw3W2i6yec
 hsGzwhGjO9JKJjGU083QxSmkwNEp5cJoMGb7aMlk5XGFsK8CkzRDeQ6K13VFVyl0ytAignKw0pK
 dqbvvKg27iOsCbdXSicCxsw0=
X-Envelope-To: stable@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id ea5506ddd254f497;
	Thu, 27 Aug 2026 05:10:30 +0000
X-Mizu-Trace-ID: ea5506ddd254f497
X-Migadu-Flow: FLOW_OUT
Message-ID: <7488c912-76bc-4412-a03f-5435ad6d4d93@linux.dev>
Date: Thu, 27 Aug 2026 13:10:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
To: Qihang <q.h.hack.winter@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: jv@jvosburgh.net, jiri@resnulli.us, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, netdev@vger.kernel.org,
 stable@vger.kernel.org, Hangbin Liu <hangbin.liu@linux.dev>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.2ec10017f4836@gmail.com>
 <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 8/27/26 11:13 AM, Qihang 写道:
> Hi Willem,
>
> I'll resend this as v2 with a cover letter.
>
> On scope: I grepped every header_ops->create.  Five devices delegate to a
> lower device (bond, team, macvlan, ipvlan, 6lowpan), but only bond and
> team re-select that lower device under RCU -- the rest bind it at netdev
> creation.  So bond and team are the full scope.
>
> Re Fixes: I used 950803f because it introduced bond_header_create (where
> this check lives); before it the type-confusion BUG masked this race.
> Happy to point at 1284cd3a2b74 instead if you prefer.
Can you check whether IPoIB + bond hits the issue you describe? That combo
isn't affected by 950803f (ipoib_hard_header doesn't use netdev_priv, no 
type

confusion), so if it overflows, the Fixes tag shouldn't point to 950803f.


