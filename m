Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692513AFCEC
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020266; cv=none; b=qXN6JEct5N2hlbGo5qf/x3ZiYPkz9em20BL3eusdW5O2QYcEs9xabQZ3tmcuueKrEsJNR1VjINSxuBt410sn+yEzP6N7LmGuMvFJAyVcuZcDqp3wsbmotA8qT1cEAcY7gMcku1yuOTey8P+TflGdweQRoPRgoLHdS1V2J7ZojRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020266; c=relaxed/simple;
	bh=0SJlxijAjMEU/gwLY5Hytz/SAIXClGwn/jgRfOYMYVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ch7oIkoq7sUic5EtK19+CKRLjZLPiQLTE+ZLSXPtCV10oG2W3evdMUJeNdxrKY9+14i5b5KgRSgRAer3hZMZFMK0czla1yNEGp/U83B7x/mFWGiS0ZcM77U8xO0qDnsF0k+Iy+2tj6y8ZWeDYiDw4CWuzmpkRz0YavdbHr1Soao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=JPa/3NRO; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="JPa/3NRO"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso2303415a12.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790020264; x=1790625064; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAoY/TRHMuFiMQq8k2l2Ct0YAPpsILvo9Udm0ZyA3Bk=;
        b=JPa/3NROAKqJbY764g4n7nMXOy6/UobZC/0ebUkBqBrY7e5cA0dRM9juebAaCoGbDT
         BtAkIrcraXzBDi9nZf0M/kxsfeJsKJB7RV/F3N24gU4vavCzzgFMP1KKx7wfDQjX1pe/
         XgdWxoJNKaHP2GbpzIY+V2M3oDCgoIlxV6K/5FO5u9GvUD/8ZWn94vk+SlSS33rNCH8S
         eft58p6Vgcx11vIJGBtDn4FpeEKN1BZ/XBqpa9KBwzQ1hVpdB+fys5yuqalk/OW85hWS
         kx7N69sbKOvz5m1c66NrudIUkTV4wGDtRNvaWVAXrSPRQfJ0oivk5J0RSvipg2CgG94Z
         7bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020264; x=1790625064;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aAoY/TRHMuFiMQq8k2l2Ct0YAPpsILvo9Udm0ZyA3Bk=;
        b=Oc8k3o6uzDh/kElqisNxI1bCHRtdsOLCIPOjbfqO5bvU+G5tp2CuQZbTuFjq0g2qxm
         EnK4wwTdqylTob3k7fN2TQzinD5UdVtEnJcBfrBx2iHbxO/RCmazHzTnJJ8bva/k2Qrf
         EUjHv8u40vwtkWYxVWHRF7bGtxQDyNLjirLJDZt6mjKMI1Q+r8MvT7DLAr5lgJ5N6i2d
         ksJ02lF1ONQtQVL+0xi2nlZgjGXYds9KTjOq6/SJDOC5rHazyaUv6C6eDdTVzca0UVry
         OKyprMkzsg2nfdGgdAHpH/4CHGR8B0Pk1BgfC+9QrvcN61/Of4545y3HuBMDEML1vVjB
         No2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxMP5hkf5h1OoFVUW0F4a+Ef3ySRwLtUyftoQT2w3YA3LhtApS4b1vvnB51fccV/yVUVI7ENnI=@vger.kernel.org
X-Gm-Message-State: AFuF++lg20EYLth6LuiXZKWnl6rdGf8+Bi5NfM3h3qGT3p6L2u6P5tCS
	WRqEeKjSw395Qrh/zxrKUt4F+PjPUvRJGD2iawi/eck1tFn3UlTqW3hxo7LLCtWgMEs=
X-Gm-Gg: AYBFou1Ha2WcpcXRH0XQbEjErKc6BdVJIK6WzAADokesgrztUsDVpIYhLft0Tgg7fer
	GXB8MKKHFjI6mCGuhRibVw0FSueE4rQ63tkwjrQeZID5kFGUTjOvy3NvK0PX9PTzWc8ILkHrYcM
	0rAhWezPALw1PcjEMyxMD7zuDqo0mVUrgUJ9Ryinan6Sq5Aq0SMHQRs2il/3KkwckcsK8BG/fqW
	/pu9F2PsVV/fR9k2wgOAIdqD5Bjh2izXEQhIPqIG5UdMUg5vuj+YmIdDTCM4IW4SC45NnsItKfJ
	2LPCrvdDOCHiAQXSGsR9NItobjmAAECDkkKUyY6kwMFsDQlbaOY6EQ5wTjaxbbmoOkyMPJLgWHt
	WdkoNTb7g3FBLFbyyWBmYXqh85KVHjfFwuYL5OO5nb4UYHI+c1JvM+fOTnS2LQsiTNV4YtjkZY5
	gcxt/lkgMC6hKM/vLAF80RsackSMs1jxWroruSBjI3XQ2+RnhlVJmj2octf2PBvHZ7Slieo+Xn3
	rN4Gan/QakD81p3LJxWoQpvVEQh3cuPSRavGgxTcrGuek73ahBWixB+4V6GbqZDDWXQmMlsd5dk
	7fU+B8DmGtLkcq+ShZtOvTIo0XTvOVpblTm9u9nUETPKWF+5F3YRGXgEduX43t/y
X-Received: by 2002:a05:6a21:517:b0:3dd:a195:fa19 with SMTP id adf61e73a8af0-3dda195fce5mr12612968637.62.1790020263620;
        Mon, 21 Sep 2026 12:51:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:8475:e6ce:2d2c:ddc2? ([2600:1700:6476:1430:8475:e6ce:2d2c:ddc2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ec6e974sm195883eec.29.2026.09.21.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:51:03 -0700 (PDT)
Message-ID: <d094915db6225a50936d6a59b7cfd7b6604ef30a.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs/hfsplus: serialize B-tree close against folio
 release
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Bruno Produit <bruno.produit@trailofbits.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dominik Czarnota
 <dominik.czarnota@trailofbits.com>, 	stable@vger.kernel.org,
 syzbot+d729df28d933979e017a@syzkaller.appspotmail.com, 
	syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com, 
	syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com, 
	syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com, 
	syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com
Date: Mon, 21 Sep 2026 12:51:01 -0700
In-Reply-To: <20260921153729.600313-1-bruno.produit@trailofbits.com>
References: <20260921153729.600313-1-bruno.produit@trailofbits.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 17:37 +0200, Bruno Produit wrote:
> B-tree nodes with a zero reference count remain in the node hash
> until
> folio reclaim or tree teardown frees them.=C2=A0 The folio release
> callbacks
> remove nodes while holding hash_lock, but hfs_btree_close() walks and
> frees the same hash without that lock.=C2=A0 Reclaim can therefore unhash
> and
> free a node after close has loaded its pointer, causing a use-after-
> free
> or double-free.=20
>=20
> The following syzkaller crashes seem to be the same UAF in=20
> {hfs,hfsplus}_btree_close() (or {hfs,hfsplus}_bnode_unhash()) and
> follow=20
> the same pattern, but do not contain a reproducer to confirm.=20
>=20
> Detach each node with hfs_bnode_unhash() while holding hash_lock
> before
> inspecting and freeing it.=C2=A0 Drop the lock before hfs_bnode_free() so
> a
> large tree is not freed while holding a spinlock.=C2=A0 Apply the same fi=
x
> to
> the matching HFS+ implementation.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+d729df28d933979e017a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd729df28d933979e017a
> Reported-by: syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2eac7d175baf21e6a5d5
> Reported-by: syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7155b2fe09e033c91381
> Reported-by: syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dadeb387cede15eb11607
> Reported-by: syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dae7f2423f3648100506d

I still don't see Cc: stable@vger.kernel.org here.

> Assisted-by: Codex:gpt-5.6-sol
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> ---
> =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0 | 7 +++++--
> =C2=A0fs/hfsplus/btree.c | 7 +++++--
> =C2=A02 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 41b4e8fc9..4f0ddc76e 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -310,14 +310,17 @@ void hfs_btree_close(struct hfs_btree *tree)
> =C2=A0		return;
> =C2=A0
> =C2=A0	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> +		spin_lock(&tree->hash_lock);
> =C2=A0		while ((node =3D tree->node_hash[i])) {
> -			tree->node_hash[i] =3D node->next_hash;
> +			hfs_bnode_unhash(node);
> +			spin_unlock(&tree->hash_lock);
> =C2=A0			if (atomic_read(&node->refcnt))
> =C2=A0				pr_err("node %d:%d still has %d
> user(s)!\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->cnid, node->th=
is,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&node->refcnt)=
);
> =C2=A0			hfs_bnode_free(node);
> -			tree->node_hash_cnt--;
> +			spin_lock(&tree->hash_lock);
> =C2=A0		}
> +		spin_unlock(&tree->hash_lock);
> =C2=A0	}
> =C2=A0	iput(tree->inode);
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 2ea8cd565..bd4dbdbc8 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -417,15 +417,18 @@ void hfs_btree_close(struct hfs_btree *tree)
> =C2=A0		return;
> =C2=A0
> =C2=A0	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> +		spin_lock(&tree->hash_lock);
> =C2=A0		while ((node =3D tree->node_hash[i])) {
> -			tree->node_hash[i] =3D node->next_hash;
> +			hfs_bnode_unhash(node);
> +			spin_unlock(&tree->hash_lock);
> =C2=A0			if (atomic_read(&node->refcnt))
> =C2=A0				pr_crit("node %d:%d "
> =C2=A0						"still has %d
> user(s)!\n",
> =C2=A0					node->tree->cnid, node-
> >this,
> =C2=A0					atomic_read(&node->refcnt));
> =C2=A0			hfs_bnode_free(node);
> -			tree->node_hash_cnt--;
> +			spin_lock(&tree->hash_lock);
> =C2=A0		}
> +		spin_unlock(&tree->hash_lock);
> =C2=A0	}
> =C2=A0	iput(tree->inode);

I haven't any comments for the fix. But let me run xfstests for the
patch (at minimum for HFS+).

Thanks,
Slava.
