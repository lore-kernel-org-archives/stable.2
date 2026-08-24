Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9E40D582
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573291; cv=pass; b=iQjsd/A22rbIrH8svNRY4Sxq2KqtO6J6U4XBNW5dDkdOFCg7MZoWgr/Sog2PkZNwJCv8RT7sLzIbCakqd28FDARjdZULVRHRomLUvhXXlx7A7R5gIcd4ttjuiNdSSrfPNrvFXUjiwJsaDXEdrcAOIoDkTxFBNythw6ByJ9Iqa24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573291; c=relaxed/simple;
	bh=vBTgILdC5cit8VdQ8ZKM6MlR+6vzAnYwYk88i/6zjws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/NMMh91xnb1upJMEWmEbzvQDkD+t9gUw+L8j1gNhSkQMnM1PpIp269laHhMynmdMjQ7t2NYdgvT0ji5l87AmGzlABzCtKV2ouiIP4/KV8KnImcSAisOJcpzQv6++x/Anwd5XKETwdXBJNvYNWLA7DnnSwXEpNDJTHbFR/KDhSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHq2xcyZ; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHq2xcyZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so615646a12.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787573288; cv=none;
        d=google.com; s=arc-20260327;
        b=mzq+nGQVC2i+yY5OLv9pcmgvQFu2LVkO005hCjPgMIRxCrT/hY4gJwX0SJP5yg/rhB
         xsaV+8gYKthdBwP8gNjo8kvDzQ2sG4bbOzdL+TbaWSyCSc/r7SzlxGb/p3KFDjVA6Ea7
         BGn2EZJM/hkE5AihvppCsuxb/b+dhADsjX887Bt2/JJFRnasNBgg1JYJLfnzuM2/dmH9
         XXyAdq2TEyF6XEiUFSEkttszKXyTVCUIydNQ9oMSkaMdS4hQrYVJvOJSqU8HvgQPzr5J
         CxbQ9rOhh/X58+UPmT6cLpUn7zA25i10rNyVWb26tGbTlYfbajx96lkkPWPc5gI5qH1/
         q1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=12nIFyq0ayHc5JfGEDps1S7MzGCCreQskB1ydTzfNLk=;
        fh=JWVUFT7QGMmbSiSYTNL2dTCcZLyXVcgmTKY+iOcKwm4=;
        b=LrsBT6+jrJfbnKistMnlLl/62AtRoGw3bwNn1OHjucYughT2nUcm2f5BnLAuHxQjhs
         iHTooOc9lHt8JuE+3tw0p2Br1F3GGQtRGLPoz+O6ampliPrRcDgeyO/3YRqqEzElZH2Y
         umU/7U9AEiqVcif83nvG6aYEiYsKtRa/uVcy8ZEfaPXPbvmmp8NilDWOO7fwxljHlMqc
         cLCraCou3cPQBmtP11Wz3u2epCOHoTuUkkmRsQrGtPmPNgvIvhNsxG7Sr6/S/uCecN4c
         p/ysVmXS7x4hxJ8KW0CW2w5Hs+Vf6oYy6efBnFMxO5TrwP3Rujp5NwbnvAX6zE+Nrw6D
         zIXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787573288; x=1788178088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=12nIFyq0ayHc5JfGEDps1S7MzGCCreQskB1ydTzfNLk=;
        b=AHq2xcyZDG/r8Y7Y/V0jQvD00Zm97ZlZhUY3Va8JZknaGc0r3jKkwxSPfD1ITUCRbS
         /sQz8IT+8Dl7JDsi9jM/RpzwTKf/lvecVwyoDnzuMBDOtUsm+4YORyPZ98qMb7FAS+No
         1mk7Oi9QjawqHCF5AYMngmYr7LdJiPRq051eyPc6O4HfCgmVDdQ8wI/avd9LaM5wueNf
         AXZ4q4N83LRlCrg1m8DOIIMvHX/rsDDadVDvyhzHFu/IzoUKFC85GcX0jSnVim5kqVo2
         egzaNN3Y/HqbdqLg6+fkuOM3WLKkA44Fw3Mh0GGmCzb8BMclXvoS4WbRb108jMHbF+QI
         /9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787573288; x=1788178088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=12nIFyq0ayHc5JfGEDps1S7MzGCCreQskB1ydTzfNLk=;
        b=TtvKSkTZqrCep3H0GFd95i1hC4F+eNfpTlxa8xCMnZB4eIc1M/RdfKIa2SGGCKxTea
         qkxvgO/93OvQsGrEDtknUDf2PxaatgKL64ZbisPuxajpTDeuxg4zlc18CBPPFMDAA8+y
         JxiepLzE87se4h5KG5oY1HrvmA1OaU8aZLYN+D6IOGWRlLndgTkgqC/gWRfyuUDkPZ8M
         aq3ItVBdDx/gab8DDPl20FUK8YIu1Vh2OstpJxo72ceXUHZQzgVjva2kJzLsIlrUq97I
         1X5H3jwXc/J/MCGR5YdOBAB0xaFo3DSxD33R8GGKzQS5vTlyE0N8u3m7O0VGbhSrmOmi
         suPg==
X-Forwarded-Encrypted: i=1; AHgh+RrXiTPpfE1GL3A4RvGrdclS7vQne3AoQELpG6GmTuAjr4V1FKYOw278ezBjPY+HwyoTTZXAViM=@vger.kernel.org
X-Gm-Message-State: AFuF++lh6QiyuCgG1MLBKt7v20BhqUxKR9/UbBduIezdIxVUGvfB3NYs
	G/SrxhZxWgURPs9bTZqD8yym/alq3c4poWBv04uwsbBWC+ouLYjHhabcw5FS9Y4oeuC2R8SIA4U
	lxnW6u/GOW5+LHvBt9pi59XyImP9VV6g=
X-Gm-Gg: AR+sD11i84ZSkZIXzoiW+0A2n81tgi4h6M4nfBY+IQOczO+2Htr8+pgAr7Ieze189t9
	W0Vyba/JheG9HnkAiol1/CrvoiHCfuiRZl2mmo+WV3jrfI56sILL++NR77dPervrhiL80zOydEp
	ciPyR+FylBC5VTw167cX35KYYeZiRtG1oCPZA5ahtwdLhAdiag57TmDtF34ed0vsd84h90ZVwuD
	VArxpt7tIs3HYLEzg3j3vGq9A7v6cIlirlZPgpTivUlWzeqhYNcADxH9t0ahTe1Tkk56EjmHBy/
	hKK5fEoYBNdyJO5a4A0piuin/vLeEt3a0nVZeXHXMRRA57WO9f6E/IlWxwnMEj9/b0/qKTiBXA=
	=
X-Received: by 2002:a05:6402:5d0:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6a42f21945emr15032938a12.2.1787573287635; Mon, 24 Aug 2026
 05:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822164055.3750284-1-nicoyip.dev@gmail.com> <GV1P189MB1988E432599B256A18EED117C6A02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988E432599B256A18EED117C6A02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 20:07:56 +0800
X-Gm-Features: AcwNN1UnPKhgwygIiR7n-fWhZO2XzKWgyAS0-UT8P-TnGmdrb6QuzlFfVBq784U
Message-ID: <CAAo+4rVXE2gsdueg3Z1A1aWvmZthCgQWQjEfC4PbAmSDCBsoDA@mail.gmail.com>
Subject: Re: [PATCH net] tipc: protect node reset trace dump with node lock
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 4:36=E2=80=AFPM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>
> Please decode above stack trace (using linux/scripts/decode_stacktrace.sh=
).
>

Decoded with linux/scripts/decode_stacktrace.sh against
(7.2.0-05126-ga4ff2be345d0-dirty #26).

BUG: KASAN: slab-use-after-free in tipc_link_dump (net/tipc/link.c:2910)
Read of size 4 at addr ffff88811c935800 by task poc/115
Call Trace:
 tipc_link_dump (net/tipc/link.c:2910)
 tipc_node_dump (net/tipc/node.c:3136)
 trace_event_raw_event_tipc_node_class (net/tipc/trace.h:327)
 tipc_node_reset_links (net/tipc/trace.h:360 / net/tipc/node.c:1337)
 tipc_rcv (net/tipc/node.c:1851 / net/tipc/node.c:2159)
 tipc_udp_recv (net/tipc/udp_media.c:389)
Allocated by task 0:
 tipc_link_create (net/tipc/link.c:490)
 tipc_node_check_dest (net/tipc/node.c:1285)
 tipc_disc_rcv (net/tipc/discover.c:252)
Freed by task 117:
 kfree (mm/slub.c:6692)
 tipc_node_link_down (net/tipc/node.c:1090)
 tipc_node_delete_links (net/tipc/node.c:1326)
 bearer_disable (net/tipc/bearer.c:414)

The KASAN is obtained by using the following kernel-side delay()
instrumentation to make the reproduction deterministic.

```
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 683a136e53ef..0e7cdbee9459 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -34,6 +34,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */

+#include <linux/delay.h>
 #include "core.h"
 #include "link.h"
 #include "node.h"
@@ -3129,7 +3130,11 @@ int tipc_node_dump(struct tipc_node *n, bool
more, char *buf)
        i +=3D scnprintf(buf + i, sz - i, " media: ");
        i +=3D tipc_media_addr_printf(buf + i, sz - i, &n->links[0].maddr);
        i +=3D scnprintf(buf + i, sz - i, "\n");
-       i +=3D tipc_link_dump(n->links[0].link, TIPC_DUMP_NONE, buf + i);
+       {
+               struct tipc_link *l0 =3D n->links[0].link;
+               mdelay(50);
+               i +=3D tipc_link_dump(l0, TIPC_DUMP_NONE, buf + i);
+       }
        i +=3D scnprintf(buf + i, sz - i, " inputq: ");
        i +=3D tipc_list_dump(&n->links[0].inputq, false, buf + i);

@@ -3138,7 +3143,11 @@ int tipc_node_dump(struct tipc_node *n, bool
more, char *buf)
        i +=3D scnprintf(buf + i, sz - i, " media: ");
        i +=3D tipc_media_addr_printf(buf + i, sz - i, &n->links[1].maddr);
        i +=3D scnprintf(buf + i, sz - i, "\n");
-       i +=3D tipc_link_dump(n->links[1].link, TIPC_DUMP_NONE, buf + i);
+       {
+               struct tipc_link *l1 =3D n->links[1].link;
+               mdelay(50);
+               i +=3D tipc_link_dump(l1, TIPC_DUMP_NONE, buf + i);
+       }
        i +=3D scnprintf(buf + i, sz - i, " inputq: ");
        i +=3D tipc_list_dump(&n->links[1].inputq, false, buf + i);
```

>
> It is not correct using read lock because trace_tipc_node_reset_links() a=
ccesses link's queues that tipc_rcv() might access concurrently.
> Please test this:
>
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 683a136e53ef..bd91378b7540 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node =
*n)
>
>         pr_warn("Resetting all links to %x\n", n->addr);
>
> +       tipc_node_write_lock(n);
>         trace_tipc_node_reset_links(n, true, " ");
> +       tipc_node_write_unlock_fast(n);
>         for (i =3D 0; i < MAX_BEARERS; i++) {
>                 tipc_node_link_down(n, i, false);
>         }
>
> >        for (i =3D 0; i < MAX_BEARERS; i++) {
> >               tipc_node_link_down(n, i, false);
> >        }
>
>

No problem, I will send a v2 to correct the fix.

Best regards,
Chengfeng
