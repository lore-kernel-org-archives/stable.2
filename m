Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089072;
	b=E2KSdXhThTzpujolNz3LlTAHrKO0dBtBem9SvraOiBm5dofOKJjg+yAWrSuF5cXW0Lc4
	 N0Ebqi/9h7x3gkkBwzsj5PEsHhEqs2lfMEzVrTTcH4Yp63BreivFdtS3xOetT6pWC9oF7
	 shhFUxVw76FHYQUD7bP1p+Y8PbdW1edhkDXKl8zeL8MSGwfj/1rRhiAXX8O4p1ZGUI/E2
	 SbPTLMaNEek0rJzL11DT63OanSUlOw5bigwt4j5oYgoEYuEH2NwyF4VNJ8+kYZ4GfpFyQ
	 hZHUFWw2CUC2gL51n5zOmpb6CTWH3g1ek5kl+rr4qgB3Ul6QfSl3IbPr/u8r8PWXKpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Feedback-ID:X-Infomaniak-Routing;
	bh=FvYoCLZcn8V8gwy8R2AOjo/wkyQs+v7pSOhs75pLsAc=;
	b=p42UsODP8Vq4RVnNu6A7cQCTku3KzXgC5XNsPVUEHPgOvGIrkd6jUP/ec9tRzL+3bAqP
	 5TzqT3DjiFlR+5r6aZzmbGSfD6bENaSRazySX5G8v8zTe75f/pVM1FmpuVNAoHJhBI3q3
	 PpeGyS8EHOnFNJ1Q3Lk22CpIaqF0PSB3HofmyEFACieUsv7KZAo08S1Wtkj26N7Jh+K6Y
	 EUkHg3cMyyDpXzGKhEVC6KoEc+bJpvAsCj7kpsyb97OafPn6Vx9XvxvIWRMa4Sp4PWdZ3
	 pUceAcCqt10N8KFHJGeKSIhyFcv76r5dAbyrbNEJaKt4/eOHe5f/dy9imcSKVcn/8Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=etik.com;
	spf=pass smtp.mailfrom=etik.com;
	arc=none smtp.remote-ip=185.125.25.12
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4C606A31D;
	Tue, 27 Oct 2026 08:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etik.com
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jDNdp64dNz1LvM;
	Tue, 27 Oct 2026 09:17:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etik.com;
	s=20210927; t=1793089054;
	bh=FvYoCLZcn8V8gwy8R2AOjo/wkyQs+v7pSOhs75pLsAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQjIb1uN7B+MBf3mFM3NKkJ4bC4V7Dt0ZLoF3OFneP+QCqXQzFFMHTd0vN8Gm5gI7
	 65QyOocl5E6oQtT2iy2U1BNziRmM8+h4iXQ2jkGQ3afx1Fqy2NVH93DJ1OX3ksgtGH
	 JvImcGSiy0SWHUBEyrDt4NBQBP5j0qsUVJE5VOFk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jDNdn5CYpzjTW;
	Tue, 27 Oct 2026 09:17:33 +0100 (CET)
From: David Vornholt <dv@etik.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Vornholt <david@vornholt.online>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Stop a power level change notification storm
Date: Tue, 27 Oct 2026 09:17:31 +0100
Message-ID: <20261027081731.122513-1-dv@etik.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <e22cf1da-89f7-4c98-a90d-357b18687df7@app.fastmail.com>
References: <20261010183917.146821-1-dv@etik.com> <at8kLPzAnJAfZRjF@black.igk.intel.com> <20261026180907.76867-1-dv@etik.com> <e22cf1da-89f7-4c98-a90d-357b18687df7@app.fastmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: :cd1c7b8f1df508f:ham:123049f310c9d1d
X-Infomaniak-Routing: alpha

Hi Mark,

On Mon, Oct 26, 2026 at 04:01:32PM -0400, Mark Pearson wrote:
> I need to read through the patch properly - but the X1 Carbon is
> quite popular and used by lots of people. Have we been able to rule
> out it being the E273m on another machine?

No, I haven't tried the E273m on another machine.

On this X1, though, I've only seen it with the E273m. The X1 has been
running v2 since the 10th, and up to the 16th its warning fired 14
times, every time with the E273m connected, on either port. The
monitor hasn't been connected since the 16th, and the warning hasn't
fired since, although the X1 has been charging over USB-C on most
days.

Right now the same port has a 20 V PD contract (the source offers up
to 20 V/5 A and PPS) with the notification enabled. The warning
hasn't fired, and GPE 0x6E stays at a few per second.

So it seems to take this EC and the E273m together. From the UCSI
side I can't tell what the EC is reacting to.

> I've created internal ticket LO-4728 so we can see if we can
> reproduce and get input from the FW team on why so many
> notifications would be generated - generated so many seems quite
> wrong.

Thank you. If it would help the FW team, I can capture the ucsi trace
events or an acpidump with the monitor connected.

> I've only skim read the proposed patch, but I'm also hesitant to say
> this is X1 C13 specific.

Agreed. This X1 is the only machine I've tested. If LO-4728 shows
that other platforms have the same problem, their board names could
go into the quirk too.

> As anote, if you do end doing a quirk then that field is bad as
> there are two different variants of the X1 Carbon 13 - ARL and LNL.
> Better to use DMI checks on the BOARD_NAME - there are two per
> platform, and I believe you're on Lunarlake so would be 21NS and
> 21NT.

Thanks. Yes, the board name here is 21NTS4EE00. If we go with the
quirk, v3 will match "21NS" and "21NT" on DMI_BOARD_NAME.

Thanks,
David
