Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6692F8E88
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786245697; cv=pass; b=BrRzhybYCYWt16lkQ9AHuPqhiP4V0D7gAT+i3/Mii253NhaSPBI7GclWqNMMTnoeeZp3o0heWsn+MwvJwMlLWCVJ34H++NICQ8ltAlu+tGt9TwtM/9NOGeN7At2noFArOksDjtnhyofePO2dO1cAZ0m23MpQc2ElazOa5KD9vrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786245697; c=relaxed/simple;
	bh=SXY4u+9DaHUNjX6GPRBNLuUHc3mmM56iddu3WgKxZ5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUCGt6WJj9XoIJHAlnMAZoJZzDyDXKbf9/uGvRzl1yxBspZWB4YtPbBX1aWAKyeiLBGd64k1SOXNTwEChu2OhPgfktJ5CVkc8tGKrJ0/X4HP+1WSomc8ZhEUJXKyf075/1BBXtcpJhzu1UinmGwdNQDUM3tEMOK1Yv1bvyCVbd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjEALtOp; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjEALtOp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e041ea211so853742a91.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 20:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786245695; cv=none;
        d=google.com; s=arc-20260327;
        b=idXDuW35Dz6/kPOmm+LgRNtMTKmPjMoO/b+HE8M4iVW+Qkd+Pj3PVcaLfiehRPHCML
         sXyrLhsusXKlsofGc8qfgT8CZd57aKFv5EcTc5id695FJQs1YQoc+rx2f71vX3uCHhHd
         R/5JmnP4E9JM4QpcpXeNKu9S77UKboRsq7HM5TcdW1kuLHSyIH9EqmIKgoe4sYaJC3/q
         coaWjy8CqnWe/asUbXy3jWdLIofLCg92ze9ReO+gS9BHZKc4zE7Fc6notoD0vesY9Xk/
         UBLf4iUjg6W/PUvYASV3KGgIlkSaA8nIWQ34H7xopKxk7kAS3XFw9UqD7cUlSKv++Rsx
         5rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNAXqNIRs3CIyk/KOlrIpIzPwG17uGFnKvl7uh5nBcw=;
        fh=Jx0YncbQEuhxfgOBLoapBypH6FtSGyFdAIkLkVcFdOY=;
        b=TaOIJWFwXW9+v7Ncek1COB2W7hO+74pm3WpmCn4ZfCGVZb5iwch9hofnkR5NJScLVz
         Smi0OarI0wns4aHBlE1NVsBZ8dnsbVB79K5OgBAuBvNFomdHtMi2rA23u/Ifr12sY3Ap
         f8zsSxVluvrmZlvODM5txw09XD2cTX9WW18X9LKCiCPDMo9JccQ/9xNpzQdSNdmTz3pv
         MG2soqbVU+DAxOGANfu+8M7t6CsA10cs06VliIxvy5ElChs1E+JeCwTOjZKG+VnnCUrs
         Dd+FEwVrCNZmrZTZXoz0DzVuzJA2PGwHVGo2/yaTDuLjFj32nQ5NE3TMNOzbp4jSRET+
         9/Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786245695; x=1786850495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zNAXqNIRs3CIyk/KOlrIpIzPwG17uGFnKvl7uh5nBcw=;
        b=pjEALtOppMnLT4oy+28yB/k7fFSuzI6qnEF/KmoHFEn/6FK+Xrnyc3GKFVrwfmWfY7
         rbPZCnkVgx7/ezGD5+QAt+BDDUdk+Qj833b2ikc2bX8ctB6dobMiBSbFRLNqraIAqiDo
         fJWamcDs09eGryDqt4NBZNOf6DJ9lZ87979zryTv/WYloL5g25jwQT/UGHPlidcbw8OY
         H7ai/9smbV+Y3Hm0bHGYMavpX4LKwIOEBZb3v6ZolMsv3YLqqO4nBXphFG+PfSyc3vaC
         qYgWnjvGR1oghhAyZMhoE/0sXiAJjaH4OZczKfwxmvt3aJRAaKJ/8AsZmltcxzJndZmX
         /paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786245695; x=1786850495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNAXqNIRs3CIyk/KOlrIpIzPwG17uGFnKvl7uh5nBcw=;
        b=ezSPLWlH0Z3o8ATsxAka0x+VFVAA0n7BttPQ7fRI5X9E9anhakCpUjJVnpxl58xB82
         9YVe6kISAYwryEjTLh+X8SnqxoQ539vJzQNrKI3UR4k2Wtn1qyDZVpCKBl1qkcZzXTLc
         hjwXlNMaL2HSBI2cGMuUCfJnAmdfErKJ1VYp+eDm8/c9PsP2Z0UniNprUHGhaSICHnQK
         EvI4q/qNOsIBRzJeh2Hha+M6xUh6CA7F/Lr9fWSd3hPJDpm/gqSTAKpLEH7BVexZLCjt
         G2RSlLi53JXPF2n1Xq1nG54U4Gsl0Fs6OB69Ua90p5RMTf/q/hhoiH31pdX9bPTW4cHP
         af8g==
X-Forwarded-Encrypted: i=1; AHgh+RqReXgjz/QZc5m1ysdDaCZNtGTg0DS6xRp5PQ7Waa6v5DN1w5Z4RBZwJuaIW2tEfjPxKekUl+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOAoE14nl8+LnsvNqd+xxkmpDJHl8iHrD5mymP/hR4X3BsGY/
	2KrJ02UKYN1IRSmj2dY0WL6VWcBvliCOqfjZ6MQC4jYIWfC28BPEljuRJKFsKewaHuPyyh0CaJM
	xGK4tJUOz7sc2C1OkxAyJxKMMyxnF2s7qrVa8kiYO
X-Gm-Gg: AR+sD10r4Ug36FTKArBbsbfmYyk6M3PyPp2m2SCISUwE0G37qQHlr+CElFeEwUz3aG6
	S4HPg+l6A+r+aBN8YQ/u9H9PQ1LdsmMUDuBRMyJv3WB256DeR6aTJu1id/FvDEALIHHViiBRCLP
	abngHFafh1VvBhhAr4o5kJwwLplzNjLZN/agEbnzqG8MSmAzdGgwtTkluDpal9IcaeFsPxeT/UE
	lqRFn9yqKaY+gd/LxmmU/x34mNtXoKNRRUt0GBJ+Y42FX+ukZKCUksgTWBU0fpgXpm9fHqivBNs
	t64sd0/xvo/5DzlVmXGQQm80bqhmKRmi7f59X/baVvd1W6ujtUN39haw8mQWVuZ8KUWuh4zNLY6
	m146DebVwmrOy0o4ki2athKOxyw43nyQysUrKAIY+fnsAv8Rpt3S8bmYtTvJ2mwWmJ0hXTS9MzX
	YCcJs6GY8zZ1g6pw==
X-Received: by 2002:a17:90b:53c5:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-3903c61098cmr36787938a91.18.1786245694545; Sat, 08 Aug 2026
 20:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com> <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
 <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com> <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
 <0A7EC161-4EE6-42D4-A10B-7B4C609C7B32@amazon.com>
In-Reply-To: <0A7EC161-4EE6-42D4-A10B-7B4C609C7B32@amazon.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 8 Aug 2026 20:21:23 -0700
X-Gm-Features: AUfX_myrEsRggJvNv33aIb9loVFZpgzUQX_MJjCGYRy9lkB6LKuULUQRXKGim50
Message-ID: <CAAVpQUAEV2XVxkEGBEoB5ocEjDS17cV4wjsVud_AHBYuUNj-SQ@mail.gmail.com>
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when
 closing sockets with pending send data
To: "Ahmed, Aaron" <aarnahmd@amazon.com>
Cc: "edumazet@google.com" <edumazet@google.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	aws-binance-tam <aws-binance-tam@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 8:42=E2=80=AFPM Ahmed, Aaron <aarnahmd@amazon.com> w=
rote:
>
> Hi,
>
> Following up since it's been a while. I've tested on 6.18.39 (latest
> 6.18.y LTS) and the issue is still present.
>
> Baseline (55,542 connections, one client SIGSTOP'd):
>   TCP: inuse 55542 orphan 0 tw 1 alloc 55543 mem 8236
>   Mem: 94504 total, 693 used
>
> After ~1 minute:
>   TCP: inuse 47394 orphan 1 tw 2 alloc 47395 mem 1404546
>   Mem: 94504 total, 9023 used
>
> Updated repo with new results and .config:
>   https://github.com/aahmed71/tcp-linger-memleak-reproducer

I ran the repro, but I didn't see the behaviour described in the
README.md; unbound growth of "mem" on the server side after
client SIGSTOP.

Before SIGSTOP, each socket on the server side has quite small
send buffer, and it grows after SIGSTOP on the client side.

A few minutes later, # of sockets decreased, and "mem" was
263705 (~=3D 1GiB) and the total send buffer was 700 MiB.
Given 1.5k MTU and skb overhead (552 bytes), it roughly matches
the "mem" value.

Also, after killing the server process, the value went down to
almost zero, and I didn't see the leak.



server side (before SIGSTOP on the client side):

---8<---
# cat /proc/sys/net/ipv4/tcp_mem ; echo; cat /proc/net/sockstat; echo; free=
 -h;

191220  254961  382440

sockets: used 45715
TCP: inuse 45577 orphan 0 tw 0 alloc 45579 mem 231374
...
               total        used        free  shared  buff/cache   availabl=
e
Mem:            15Gi   2.3Gi        13Gi   332Ki       159Mi        13Gi
Swap:             0B          0B          0B
---8<---

---8<---
ESTAB    0      1912     192.168.0.1:6666  192.168.0.2:24543
ESTAB    0      3100     192.168.0.1:6666  192.168.0.2:10770
ESTAB    0      9640     192.168.0.1:6666  192.168.0.2:47995
ESTAB    0      2160     192.168.0.1:6666  192.168.0.2:27574
---8<---


server side (after SIGSTOP on the client side):

---8<---
191220  254961  382440

sockets: used 753
TCP: inuse 606 orphan 0 tw 0 alloc 608 mem 263705
...
               total        used        free  shared  buff/cache   availabl=
e
Mem:            15Gi   4.4Gi        11Gi   332Ki       156Mi        11Gi
Swap:             0B          0B          0B
---8<---

---8<---
ESTAB  0      217341   192.168.0.1:6666  192.168.0.2:25684
ESTAB  0      120004   192.168.0.1:6666  192.168.0.2:23340
ESTAB  0      128672   192.168.0.1:6666  192.168.0.2:48728
ESTAB  0      141194   192.168.0.1:6666  192.168.0.2:41513
ESTAB  0      121421   192.168.0.1:6666  192.168.0.2:33507
---8<---

---8<---
# ss -tn | awk 'NR>1 { count++; sum +=3D $3 } END { printf "Sockets: %d
| Send-Q Total: %.2f MiB (%d bytes)\n", count, sum/1024/1024, sum }'
Sockets: 601 | Send-Q Total: 722.04 MiB (757118970 bytes)
---8<---

---8<---
$ pahole -C sk_buff
...
 /* size: 232, cachelines: 4, members: 28 */
...
$ pahole -C skb_shared_info
...
 /* size: 320, cachelines: 5, members: 13 */
---8<---
