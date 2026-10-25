Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792913898;
	b=Hc4HsjYRf/SbbI1ExCh2we4BJM4mAdMUwzX8Tvfw4A02sro/DHRRl5WPzh9XYKzesTWf
	 T26wPjhwWzA0NHOVkCFuqEB6w0SfvTdrbdTzc765jAvXP98yYnbhG8/GfUeVvJW1FDwRG
	 9rMmNPAJB7A2Db2qfhmOuSHVNHvHj4RLcW7oavOM5bC/+cGHfv0hNn5i54ji3T/RbDLnV
	 rBGgf4xsmqYzPGk9xRTnV4x2fu2MR8sBEKsYp12ReEydpa4ubKwERa0LrjW4yCn6bHvsy
	 9HCB4wuIeD5PT2IH6p0Q5pRtAMGcmo23jyq5KvTJxlYRneJprM3+lbr9Adk0mqYHLIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792913898;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=qDksTMI7Q2vrt5sUJIBiWWP7Ncj+R+k+fqZL0nlAVnA=;
	b=zzhxwkzL/WnuGNRMUzfPPQucDhRbUVkyv2JEaeQ3mzdouHt1VTILt2Z32N28ptbegUaZ
	 2hOc5ol6mXOPttZcz1iuk2DLnf9EO0ud89qOmdbEz5aqkPo3KV3z+VQE1Zpi4sDyCex5o
	 UNvzvrNPRSF0f2flJYzvQytXBp+vewAP62PJDQOMvOgJW/C1ClapcXo7xjG4WhvAm65/G
	 kONRAXxaWlTeJqqOJsq8rhg+1f6dpuG3612t593FCtrASJ6SpweTULECJE5s4OzQolwtZ
	 +hi+YeydjZQkYaMDnjbRCdTv9Vglv/hMT9SyW/w0DEhVZ4XylTABMthw6cEprJ7mpSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=online.de;
	spf=pass smtp.mailfrom=online.de;
	dkim=pass header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=bn860dGQ;
	arc=none smtp.remote-ip=217.72.192.75
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419F606A31A;
	Sun, 25 Oct 2026 07:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6419F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=bn860dGQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1792913870; x=1793518670; i=cito@online.de;
	bh=qDksTMI7Q2vrt5sUJIBiWWP7Ncj+R+k+fqZL0nlAVnA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bn860dGQdTFTW4Yukf8zC4zBxqc24zCtM6FaUKQ0SX2XBkr02l0M/vHn3IasBIHB
	 7XnVzeqc7OxXCASBc50aVtrormxIn8IO8+MMJ4h/e3ARbqzw3Ac5mR8VdHb7cAeX6
	 JUERkI4nXYPqK+I8Mxs/PdGkxeJ/6wbUOUDyZR/OeaGuT+793ooOhzUI5GgtrwToT
	 lvSqexZxcurWgFYYiLIqe6P2qRqFhC8BxrHpp9VM83S0aqKICWFmkxY/NdBz1kbF6
	 O+AwgMi8fJHtx70BOIsYPCzvbBSgWCOH43XkQdDlXbvW6HyFBr/3SYBN7zM4Dihi5
	 /7J2bSogZ6gje30Oxg==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MEmEf-1xNJeX3IXD-002wD1; Sun, 25
 Oct 2026 08:37:50 +0100
Message-ID: <3bc2cf5d-6cd2-49ae-91e2-ed3af96362f2@online.de>
Date: Sun, 25 Oct 2026 08:37:49 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore working
 on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests firmware)
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Erik Brangs <erik.brangs@gmx.de>, benh@debian.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 1149377@bugs.debian.org
References: <8aa88f3e-2dd7-4bfe-a0f3-e5ecbbade84f@leemhuis.info>
 <2026-10-24-1-daily-reply-0001-bluetooth-asus-rtl8761cu-firmware@kernel.org>
 <2026102508-thicket-duration-c971@gregkh>
 <6299a7bd-a934-41b2-95f9-d68056551714@leemhuis.info>
Content-Language: en-US
From: Christoph Zwerschke <cito@online.de>
In-Reply-To: <6299a7bd-a934-41b2-95f9-d68056551714@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2fhjPZOR/ZFlzzmWClBm38W8b35oj3iqamAHBiPlrR6xdmL3Lt4
 LC94OqbU2ffqRjWOwHhY8XC97a7rjdbfiqfPx/AHz8Vz6AzTEzM1eaBG0A6q+YudMzmy2ve
 TBkIN/xTy1gb+fO0u1gzcw0DcZlT0wEZTI5Iq3qolrI3GjDf7oP4UuK7PMeM2lvq/Wv3whE
 z3AGwZB1ZqhnYvxQQK9zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D6hZEqoX4EA=;ewhZCI5H0RVZZEgpF4frABKoZGO
 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
 umcuDlpcIeDxZdaeK4CzQ==

On 25.10.26 07:27, Thorsten Leemhuis wrote:
> Feels wrong to me, as
> Documentation/driver-api/firmware/firmware-usage-guidelines.rst says
> "Users switching to a newer kernel should *not* have to install newer
> firmware files to keep their hardware working.". So what those three
> commits did in mainline even there could be considered a
> mistake/regression. No worries, mistakes happen. And reverting it now in
> mainline would do more damage than good. But overall it feels wrong to
> bring that mistake over to older stable series.
Hi Thorsten, all,

I can confirm the analysis: with the two ID entries, btusb hands both
adapters to btrtl, which, with 4a23ce935f74 ("Bluetooth: btrtl: Add
the support for RTL8761CUV"), requires rtl_bt/rtl8761cu_fw.bin and
aborts the setup if the file is missing.

The original commit messages of my two ID commits, 980084de4d9b
("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU") and
6f0624b4427e ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
8761CU"), say that without the entries the controllers are
"non-functional". I had concluded that from earlier experiments
where things did not work as expected, and I wrongly blamed that
on the firmware not being loaded. In fact the adapters work fine
on their ROM firmware; the problems had other causes. It seems
that when I prepared the patches in July, I did not properly test
the adapters without the entries, and I tested the patches only on
7.1, where btrtl already supports the RTL8761CU.

What I should have done: test the unpatched adapters first, test the
stable trees the patches would reach, and consider systems without
rtl8761cu_fw.bin. As it is, the patches made things worse, first in
the trees without the btrtl commit and now for everyone with older
firmware. I'm sorry for the trouble this has caused, especially to
Ralf, Erik, and the stable and Debian maintainers.

I have now tested more thoroughly, with both adapters (BT540
0b05:1bef, BT600 0b05:1d70), re-plugging before each case, using
linux-firmware 20261019 with the rtl8761cu files hidden or present.
Kernels were CachyOS 7.3.0 and 6.18.55, with btusb built from the
v7.3 and v6.18.55 sources, with and without the ID entries:

- 7.3 and 6.18.55, IDs present, firmware hidden: "firmware file
   rtl_bt/rtl8761cu_fw not found", no controller (as Erik reported).
- 7.3 and 6.18.55, both ID entries removed (i.e. the two ID commits
   reverted, the btrtl commit kept), firmware hidden: no btrtl
   involvement, the adapters run on ROM firmware (lmp_subver 0x8761),
   A2DP works.
- 7.3, ID entries removed, firmware present: same, ROM firmware, A2DP
   works.

Regarding your concern that a revert in mainline would do more damage
than good: on 7.3 I also compared both variants (with and without the
ID entries) with the BT600 for HFP and LE Audio (BlueZ 5.87, PipeWire
1.6.10). mSBC is negotiated and used even without the wide-band-speech
flag, and I found no difference between ROM and loaded firmware. So
for these two adapters I could not find any damage from reverting the
ID entries in mainline. Of course this does not rule out that the
loaded firmware contains fixes or improvements that my tests did not
cover.

For these two adapters, the btrtl commit 4a23ce935f74 (RTL8761CUV
support in btrtl) does not need to be reverted: without the ID
entries, they never reach btrtl (no "RTL:" lines at all in the logs).
What reverting it would mean for other RTL8761CU devices, e.g. with
Realtek's own vendor ID, I cannot say.

Not tested: 6.12, other RTL8761CU devices, HFP and LE Audio on 6.18,
and older audio stacks that might evaluate the wide-band-speech flag.

If it helps, I can send reverts of 980084de4d9b and 6f0624b4427e
(on top of bluetooth.git master, with Cc: stable). Alternatively,
btrtl could fall back to the ROM firmware when rtl8761cu_fw.bin
is missing.

Thanks,
Christoph
